Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E100CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 07:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BCFC40E0A;
	Thu,  6 Nov 2025 08:50:27 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BDFDF4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 08:50:25 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 95F232079A;
 Thu,  6 Nov 2025 08:50:25 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mbuf: improve mbuf comments
Date: Thu, 6 Nov 2025 08:50:23 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65536@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <11692478.3WhfQktd6Z@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mbuf: improve mbuf comments
Thread-Index: AdxOmzR/qSrExWBwRh+WXrsEdrenwgAUTXkQ
References: <20251105112810.20838-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65530@smartserver.smartshare.dk>
 <11692478.3WhfQktd6Z@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>
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

PiA+IFR5cG86IFRYIGRlc2NyaXB0b3IgLT4gUlggZGVzY3JpcHRvci4NCj4gDQo+IEFub3RoZXIg
VHlwbzogUlggLT4gUnggOykNCj4gDQo+IFdlIGFncmVlZCB0byBwcmVmZXIgVHgvUnggY2FwaXRh
bGl6YXRpb24gaW4gZGV2dG9vbHMvd29yZHMtY2FzZS50eHQuDQo+IEkgcGVyc29ubmFseSB0aGlu
ayBpdCBpcyBtb3JlIGNvcnJlY3QsIGFzIGl0IGlzIG5vdCBhbiBhY3JvbnltLg0KDQpJdCBpcyBh
biBhY3JvbnltLCBhbmQgSSB0aGluayBSWC9UWCBpcyBnZW5lcmFsbHkgbW9yZSBjb21tb24gdGhh
biBSeC9UeC4NCkhvd2V2ZXIsIGFmdGVyIGNoZWNraW5nIHdpdGggQ2xhdWRlLCBJJ2xsIHJlc3Bl
Y3QgdGhlIGRlY2lzaW9uIHRvIHVzZSBSeC9UeC4NClBsZWFzZSBmaXggdGhlIHNwZWxsaW5nIHdo
aWxlIG1lcmdpbmcuDQoNCk15IGRlZ3JlZSBpcyBpbiBlbGVjdHJpY2FsIGVuZ2luZWVyaW5nLCBu
b3QgY29tcHV0ZXIgc2NpZW5jZSwgYW5kIENsYXVkZSBjb25maXJtcyB0aGF0IFJYL1RYIGlzIG1v
cmUgY29tbW9uIGZvciBlbGVjdHJvbmljcywgd2hpbGUgUngvVHggaXMgZ2VuZXJhbGx5IHByZWZl
cnJlZCBmb3IgcmVhZGFiaWxpdHkuDQpTbyBJIGxlYXJuZWQgc29tZXRoaW5nIG5ldyBhYm91dCBz
cGVsbGluZyB0b2RheS4gOy0pDQoNCkNsYXVkZToNClE6IFdoYXQgaXMgdGhlIG9yaWdpbiBvZiB0
aGUgc2hvcnRoYW5kIGZvcm0gUnggYW5kIFR4LCBhbmQgd2hpY2ggc3BlbGxpbmcgaXMgbW9zdCBj
b21tb25seSB1c2VkLCBSWC9UWCBvciBSeC9UeD8NCkE6DQoNClRoZSBzaG9ydGhhbmQgIlJ4IiBh
bmQgIlR4IiBoYXZlIGRpZmZlcmVudCBvcmlnaW5zIGRlcGVuZGluZyBvbiB0aGUgY29udGV4dDoN
Cg0KSW4gTWVkaWNpbmUvUGhhcm1hY3kNClJ4IGNvbWVzIGZyb20gTGF0aW4gYW5kIGhhcyBiZWVu
IHVzZWQgc2luY2UgbWVkaWV2YWwgdGltZXMuIEl0J3MgZGVyaXZlZCBmcm9tIHRoZSBMYXRpbiB3
b3JkICJyZWNpcGUiIChtZWFuaW5nICJ0YWtlIiBvciAicmVjZWl2ZSIpLCB3aGljaCB3YXMgd3Jp
dHRlbiBhdCB0aGUgYmVnaW5uaW5nIG9mIHByZXNjcmlwdGlvbnMuIE92ZXIgdGltZSwgdGhlICJS
IiB3aXRoIGEgY3Jvc3NlZCB0YWlsIGV2b2x2ZWQgaW50byB0aGUgc3ltYm9sIOKEniBhbmQgdGhl
biB0aGUgc2hvcnRoYW5kICJSeC4iIFRoaXMgaXMgd2h5IHByZXNjcmlwdGlvbnMgYXJlIG9mdGVu
IGNhbGxlZCAiUnguIg0KDQpUeCBpbiBtZWRpY2FsIGNvbnRleHRzIGlzIGEgbW9kZXJuIGFiYnJl
dmlhdGlvbiBmb3IgInRyZWF0bWVudCIgb3IgInRoZXJhcHksIiBsaWtlbHkgY3JlYXRlZCBieSBh
bmFsb2d5IHdpdGggUnguDQoNCkluIEVsZWN0cm9uaWNzL1RlbGVjb21tdW5pY2F0aW9ucw0KUngg
c3RhbmRzIGZvciAicmVjZWl2ZSIgb3IgInJlY2VpdmVyIiBUeCBzdGFuZHMgZm9yICJ0cmFuc21p
dCIgb3IgInRyYW5zbWl0dGVyIg0KDQpUaGVzZSBhYmJyZXZpYXRpb25zIGJlY2FtZSBzdGFuZGFy
ZCBpbiByYWRpbywgdGVsZWNvbW11bmljYXRpb25zLCBhbmQgZGlnaXRhbCBjb21tdW5pY2F0aW9u
cyB0byBsYWJlbCBzaWduYWwgcGlucywgY2lyY3VpdHMsIGFuZCBkYXRhIGxpbmVzLg0KDQpDYXBp
dGFsaXphdGlvbiBDb252ZW50aW9uDQpCb3RoIFJYL1RYIGFuZCBSeC9UeCBhcmUgd2lkZWx5IHVz
ZWQsIGJ1dCB0aGUgcHJlZmVyZW5jZSB2YXJpZXMgYnkgZmllbGQ6DQoNCkVsZWN0cm9uaWNzL0Vu
Z2luZWVyaW5nOiBSWC9UWCAoYWxsIGNhcHMpIGlzIG1vcmUgY29tbW9uLCBlc3BlY2lhbGx5IG9u
IHRlY2huaWNhbCBkaWFncmFtcywgY2lyY3VpdCBib2FyZHMsIGFuZCBkYXRhIHNoZWV0cw0KTWVk
aWNpbmU6IFJ4IChjYXBpdGFsIFIsIGxvd2VyY2FzZSB4KSBpcyB0cmFkaXRpb25hbCBhbmQgc3Rh
bmRhcmQNCkdlbmVyYWwgd3JpdGluZzogUngvVHggKG1peGVkIGNhc2UpIGlzIG9mdGVuIHVzZWQg
Zm9yIHJlYWRhYmlsaXR5DQpJbiB0ZWNobmljYWwgZG9jdW1lbnRhdGlvbiBmb3IgZWxlY3Ryb25p
Y3MsIHlvdSdsbCBzZWUgYm90aCBzdHlsZXMsIGJ1dCBSWC9UWCB0ZW5kcyB0byBiZSBzbGlnaHRs
eSBtb3JlIHByZXZhbGVudCBpbiBwcm9mZXNzaW9uYWwgY29udGV4dHMuIEhvd2V2ZXIsIGJvdGgg
YXJlIHBlcmZlY3RseSBhY2NlcHRhYmxlIGFuZCB3aWRlbHkgdW5kZXJzdG9vZC4NCg0K
