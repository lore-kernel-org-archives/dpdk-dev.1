Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B696ED64095
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 08:58:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C133B40275;
	Wed, 17 Dec 2025 09:58:57 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 09FE94026C;
 Wed, 17 Dec 2025 09:58:55 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWSPy1m7PzHnGgf;
 Wed, 17 Dec 2025 16:58:30 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id 29E2740565;
 Wed, 17 Dec 2025 16:58:55 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 09:58:54 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 17 Dec 2025 09:58:54 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Jerin Jacob <jerinjacobk@gmail.com>, =?utf-8?B?TW9ydGVuIEJyw7hydXA=?=
 <mb@smartsharesystems.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, dev <dev@dpdk.org>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH v2 3/5] bpf: disallow empty program
Thread-Topic: [PATCH v2 3/5] bpf: disallow empty program
Thread-Index: AQHcbrjX7de0N7xpe0a3kFh3QAHAAbUmg2kA//8FInA=
Date: Wed, 17 Dec 2025 08:58:54 +0000
Message-ID: <061fb1f043a64b448676dd757790c4bd@huawei.com>
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251216182036.77869-1-marat.khalili@huawei.com>
 <20251216182036.77869-4-marat.khalili@huawei.com>
 <CAOaVG17N6Qi-Ovk99R9vEQRzVXbeUR6JG6h2smEOAcS8zgUNpQ@mail.gmail.com>
In-Reply-To: <CAOaVG17N6Qi-Ovk99R9vEQRzVXbeUR6JG6h2smEOAcS8zgUNpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.79.8]
Content-Type: multipart/alternative;
 boundary="_000_061fb1f043a64b448676dd757790c4bdhuaweicom_"
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

--_000_061fb1f043a64b448676dd757790c4bdhuaweicom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBJIHNlZSBubyBuZWVkIGZvciBkb2Nib29rIHN0eWxlIGNvbW1lbnRzIGZvciBzdGF0aWMgZnVu
Y3Rpb25zLg0KPiBFc3BlY2lhbGx5IGluIHRlc3Qgb25seSBjb2RlDQoNClRoYW5rIHlvdSwgd2ls
bCByZW1lbWJlciBpdCBhbmQgcmVtb3ZlIGFuZCBuZXh0IGl0ZXJhdGlvbi4NCg==

--_000_061fb1f043a64b448676dd757790c4bdhuaweicom_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkRlbmdYaWFuOw0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAx
IDE7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpDYWxpYnJpOw0KCXBhbm9zZS0xOjIgMTUg
NSAyIDIgMiA0IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6IlxARGVuZ1hpYW4i
Ow0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAxIDE7fQ0KLyogU3R5bGUgRGVmaW5pdGlvbnMg
Ki8NCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWwsIGRpdi5Nc29Ob3JtYWwNCgl7bWFyZ2luOjBj
bTsNCglmb250LXNpemU6MTEuMHB0Ow0KCWZvbnQtZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlm
O30NCnNwYW4uRW1haWxTdHlsZTIwDQoJe21zby1zdHlsZS10eXBlOnBlcnNvbmFsLWNvbXBvc2U7
DQoJZm9udC1mYW1pbHk6IkNhbGlicmkiLHNhbnMtc2VyaWY7DQoJY29sb3I6d2luZG93dGV4dDt9
DQouTXNvQ2hwRGVmYXVsdA0KCXttc28tc3R5bGUtdHlwZTpleHBvcnQtb25seTsNCglmb250LWZh
bWlseToiQ2FsaWJyaSIsc2Fucy1zZXJpZjt9DQpAcGFnZSBXb3JkU2VjdGlvbjENCgl7c2l6ZTo2
MTIuMHB0IDc5Mi4wcHQ7DQoJbWFyZ2luOjcyLjBwdCA3Mi4wcHQgNzIuMHB0IDcyLjBwdDt9DQpk
aXYuV29yZFNlY3Rpb24xDQoJe3BhZ2U6V29yZFNlY3Rpb24xO30NCi0tPjwvc3R5bGU+PCEtLVtp
ZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWRlZmF1bHRzIHY6ZXh0PSJlZGl0IiBzcGlkbWF4
PSIxMDI2IiAvPg0KPC94bWw+PCFbZW5kaWZdLS0+PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+DQo8
bzpzaGFwZWxheW91dCB2OmV4dD0iZWRpdCI+DQo8bzppZG1hcCB2OmV4dD0iZWRpdCIgZGF0YT0i
MSIgLz4NCjwvbzpzaGFwZWxheW91dD48L3htbD48IVtlbmRpZl0tLT4NCjwvaGVhZD4NCjxib2R5
IGxhbmc9IkVOLVVTIiBsaW5rPSJibHVlIiB2bGluaz0icHVycGxlIiBzdHlsZT0id29yZC13cmFw
OmJyZWFrLXdvcmQiPg0KPGRpdiBjbGFzcz0iV29yZFNlY3Rpb24xIj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPiZndDsgSSBzZWUgbm8gbmVlZCBmb3IgZG9jYm9vayBzdHlsZSBjb21tZW50cyBmb3Ig
c3RhdGljIGZ1bmN0aW9ucy48bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPiZn
dDsgRXNwZWNpYWxseSBpbiB0ZXN0IG9ubHkgY29kZTxvOnA+PC9vOnA+PC9wPg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5U
aGFuayB5b3UsIHdpbGwgcmVtZW1iZXIgaXQgYW5kIHJlbW92ZSBhbmQgbmV4dCBpdGVyYXRpb24u
PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_061fb1f043a64b448676dd757790c4bdhuaweicom_--
