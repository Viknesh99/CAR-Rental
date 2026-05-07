import { Component } from '@angular/core';
import { CustomerService } from '../../services/customer.service';
import { NzMessageService } from 'ng-zorro-antd/message';

@Component({
  selector: 'app-customer-dashboard',
  templateUrl: './customer-dashboard.component.html',
  styleUrls: ['./customer-dashboard.component.scss']
})
export class CustomerDashboardComponent {

  cars: any = [];

  constructor(private customerService: CustomerService,
    private message: NzMessageService) {
    this.getAllCars();
  }

  getAllCars() {
    this.customerService.getAlCars().subscribe((res) => {
      console.log(res);
      res.forEach(element => {
        element.processedImg = element.returnedImage
          ? 'data:image/jpeg;base64,' + element.returnedImage
          : null;
        this.cars.push(element);
      });
    }, error => {
      console.error('Failed to load cars', error);
    })
  }

}
