Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B069C83F17
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Jul 2025 10:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C21B402A9;
	Sun, 13 Jul 2025 12:45:32 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 66B854028F;
 Sun, 13 Jul 2025 12:45:30 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bg27x37xFz6L4vM;
 Sun, 13 Jul 2025 18:42:05 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 524571402F2;
 Sun, 13 Jul 2025 18:45:29 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Jul 2025 12:45:29 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Sun, 13 Jul 2025 12:45:29 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "techboard@dpdk.org" <techboard@dpdk.org>
Subject: Techboard meeting minutes, 2025-July-09
Thread-Topic: Techboard meeting minutes, 2025-July-09
Thread-Index: AdvzLu41eBpdl9+4SzajyNR8CflREw==
Date: Sun, 13 Jul 2025 10:45:29 +0000
Message-ID: <e40b8e7ffc7844699f807ffd64c41786@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.155.55]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

TWludXRlcyBvZiBUZWNobmljYWwgQm9hcmQgTWVldGluZywgMjAyNS1KdWx5LTA5DQoNCk1lbWJl
cnMgYXR0ZW5kaW5nDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCi0gQWFyb24gQ29ub2xl
DQotIEJydWNlIFJpY2hhcmRzb24NCi0gSGVtYW50IEFncmF3YWwNCi0gSmVyaW4gSmFjb2INCi0g
S29uc3RhbnRpbiBBbmFueWV2IChjaGFpcikNCi0gTW9ydGVuIEJyw7hydXANCi0gU3RlcGhlbiBI
ZW1taW5nZXINCi0gVGhvbWFzIE1vbmphbG9uDQoNCk5PVEU6IFRoZSB0ZWNobmljYWwgYm9hcmQg
bWVldGluZ3MgZXZlcnkgc2Vjb25kIFdlZG5lc2RheSBhdA0KaHR0cHM6Ly96b29tLWxmeC5wbGF0
Zm9ybS5saW51eGZvdW5kYXRpb24ub3JnL21lZXRpbmcvOTY0NTk0ODgzNDA/cGFzc3dvcmQ9ZDgw
OGYxZjYtMGEyOC00MTY1LTkyOWUtNWE1YmNhZTdlZmViDQphdCAzIHBtIFVUQy4NCk1lZXRpbmdz
IGFyZSBwdWJsaWMsIGFuZCBEUERLIGNvbW11bml0eSBtZW1iZXJzIGFyZSB3ZWxjb21lIHRvIGF0
dGVuZC4NCkFnZW5kYSBhbmQgbWludXRlcyBjYW4gYmUgZm91bmQgYXQgaHR0cDovL2NvcmUuZHBk
ay5vcmcvdGVjaGJvYXJkL21pbnV0ZXMuDQpOT1RFOiBOZXh0IG1lZXRpbmcgd2lsbCBiZSBvbiBX
ZWRuZXNkYXkgMjAyNS0gSnVseSAtIDIzdGggQDNwbSBVVEMsIGFuZA0Kd2lsbCBiZSBjaGFpcmVk
IGJ5IE1vcnRlbi4NCg0KQWdlbmRhIEl0ZW1zOg0KPT09PT09PT09PT09DQoNCjEpIFNhbnRhIENs
YXJhIHN1bW1pdCB1cGRhdGUgKE5hdGhhbiwgSGVtYW50KQ0KICBDRlAgZGVhZGxpbmUgd2FzIGV4
dGVuZGVkIHRpbGwgSnVseSA2dGguDQogIEhlbWFudCBhbmQgb3RoZXIgVEIgbWVtYmVycyByYWlz
ZWQgYSBjb25jZXJuIHRoYXQgc2V2ZXJhbCBzdWJtaXNzaW9ucyB3ZXJlDQogIHByb2JhYmx5IGdl
bmVyYXRlZCBieSBBSSBib3RzIGFuZC9vciBkb2Vzbid0IHJlbGF0ZSB0byBhY3R1YWwgRFBESy1y
ZWxhdGVkIHRvcGljcy4NCiAgQVIgdG8gYWxsIFRCIG1lbWJlcnMgdG8gcmV2aWV3IHRoZSBzdWJt
aXNzaW9ucyBhbmQgcHJvdmlkZSB0aGUgc2NvcmluZy4gICAgDQogIEFSIHRvIE5hdGhhbiBhbmQg
b3RoZXIgc3VtbWl0IG9yZ2FuaXplcnMgdG8gY29udGFjdCBzdWJtaXR0ZXJzIGFuZCBjbGFyaWZ5
IHRoZWlyDQogIHByZXNlbnRhdGlvbiB0b3BpY3MuDQogIENvbnNlbnN1cyBvZiAgYWxsIFRCIG1l
bWJlcnMgdGhhdCBzdGFydGluZyBmcm9tIG5leHQgY29uZmVyZW5jZSwgdG8gcHJvaGliaXQgDQog
IHN1Ym1pc3Npb25zIG9mIEFJIGdlbmVyYXRlZCBzdW1tYXJpZXMuIA0KDQoyKSBvZiBWTEFOIHRh
ZyBhbmQgUWluUSBzdHJpcHBpbmcgKEJydWNlKQ0KRm9yIGJhY2tncm91bmQgc2VlIGRpc2N1c3Np
b24gaW4gdGhpcyB0aHJlYWQ6DQpodHRwczovL2luYm94LmRwZGsub3JnL2Rldi8yMzYxOWI0MC0x
YjVhLTQyZDUtODE2Ni1kZWY5ZjA5ODAxNzVAaW50ZWwuY29tL1QvI21jOGQ5MTI5MzExYTVkODFl
YTZmOGRkMmE1ODYyOWQ3NjQ1Y2M4MGI5DQpUaGUgZG9jdW1lbnRhdGlvbiAtIGJvdGggaW4gdGhl
IE5JQyBndWlkZSBhbmQgdGhlIHRlc3RwbWQgZ3VpZGUgaXMgcmF0aGVyIHNob3J0IG9uIGRldGFp
bCBhcyB0byB3aGF0IGV4YWN0bHkgdGhlIGJlaGF2aW9yIHNob3VsZCBiZQ0Kd2hlbiBWTEFOIHN0
cmlwIGFuZC9vciBRSU5RIHN0cmlwIGlzIGltcGxlbWVudGVkLiBBZ2FpbiwgdGhlcmUgaXMgYSBz
dXNwaWNpb24gdGhhdCBub3QgYWxsIGV4aXN0aW5nIEhXIGRyaXZlcnMgYmVoYXZlIGluIHRoZSBz
YW1lIHdheS4NCkJydWNlIHBsYW5zIHRvIHN1Ym1pdCBhIHNlcmllcyBvZiBwYXRjaGVzIHRvIGNs
ZWFybHkgZG9jdW1lbnQgYW4gZXhwZWN0ZWQgYmVoYXZpb3IgYW5kIHByb3ZpZGUgRFRTIHRlc3Qt
Y2FzZXMgZm9yIHRoYXQuDQpGdXJ0aGVyIGRpc2N1c3Npb24gdG8gY29udGludWUgdGhvdWdoIHBh
dGNoIHJldmlldyBtYWlscywgZXRjLg0KDQozKSBGZXcgcmVtaW5kZXJzIHRvIGFsbCBjb21tdW5p
dHkgbWVtYmVyczoNCiAgICAtIEFhcm9uOiAgUGxlYXNlIHJldmlldyBhbmQgcHJvdmlkZSBhIGZl
ZWRiYWNrIGZvciBBSSBiYXNlZCBjb2RlIHJldmlldyBwcm9wb3NhbDoNCiAgICAgIGh0dHBzOi8v
aW5ib3guZHBkay5vcmcvZGV2L2Y3dGg1enVzcmxhLmZzZkByZWRoYXQuY29tL1QvI3QNCiAgIC0g
VGhvbWFzOiBBcyAyNS4wNyBkZWFkbGluZSBpcyBsb29taW5nIHBsZWFzZSByZXZpZXcgcGVuZGlu
ZyBkb2MgcGF0Y2hlcywNCiAgICAgc3BlY2lhbGx5IGRlcHJlY2F0aW9uIG5vdGljZXMuICAgIA0K
