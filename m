Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BE7D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:13:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B14540270;
	Tue,  9 Dec 2025 12:13:22 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 23EEC4025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:13:19 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 050C8206A1;
 Tue,  9 Dec 2025 12:13:19 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH dpdk 1/2] graph: always count objects and calls
Date: Tue, 9 Dec 2025 12:13:16 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655C8@smartserver.smartshare.dk>
In-Reply-To: <DETKJKSUL9XG.1CTKW09I3UWSB@redhat.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH dpdk 1/2] graph: always count objects and calls
Thread-Index: Adxo6//p2vxeTvU6SVCIUZNtkqq/2wAD9eHA
References: <20251209085028.115203-4-rjarry@redhat.com>
 <20251209085028.115203-5-rjarry@redhat.com>
 <CALBAE1OMwTX=a5i56G_sPXicw=17ozvb4PBfak0ev2Ps3xwuGw@mail.gmail.com>
 <DETKJKSUL9XG.1CTKW09I3UWSB@redhat.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Robin Jarry" <rjarry@redhat.com>,
	"Jerin Jacob" <jerinjacobk@gmail.com>
Cc: <dev@dpdk.org>, "Jerin Jacob" <jerinj@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Zhirun Yan" <yanzhirun_163@163.com>
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

PiBGcm9tOiBSb2JpbiBKYXJyeSBbbWFpbHRvOnJqYXJyeUByZWRoYXQuY29tXQ0KPiBTZW50OiBU
dWVzZGF5LCA5IERlY2VtYmVyIDIwMjUgMTAuMTMNCj4gDQo+IEplcmluIEphY29iLCBEZWMgMDks
IDIwMjUgYXQgMTA6MDk6DQo+ID4gQnkgZGVmYXVsdCwgUlRFX0xJQlJURV9HUkFQSF9TVEFUUyBp
cyBlbmFibGVkIGluIGRpc3RybyBidWlsZC4gU28gd2h5DQo+ID4gbmVlZCBzdWNoIGNoYW5nZXM/
DQo+IA0KPiBUaGlzIG1ha2VzIHNlbnNlIHdpdGggdGhlIG5leHQgcGF0Y2ggaW4gZmFjdC4NCj4g
DQo+IFRoZSB1c2VyIChlLmcuIGdyb3V0KSBtYXkgbmVlZCB0byBjb2xsZWN0IHRoZSBudW1iZXIg
b2YgcHJvY2Vzc2VkDQo+IG9iamVjdHMgaW4gb3JkZXIgdG8gbWFrZSBydW50aW1lIGRlY2lzaW9u
cy4gQnV0IHRoZSBjb3N0IG9mIHJkdHNjKCkgbWF5DQo+IGJlIHRvbyBoaWdoIGFuZCBpdCBtYXkg
YmUgYSBnb29kIHRoaW5nIHRvIGRpc2FibGUgaXQgdW5sZXNzIHRyeWluZyB0bw0KPiBiZW5jaG1h
cmsvZGVidWcgc3BlY2lmaWMgaXNzdWVzLg0KDQpMb29raW5nIGF0IHBhdGNoIDIvMiwgSSBkaXNh
Z3JlZSB3aXRoIHRoZSBhcHByb2FjaC4NCg0KUlRFX0xJQlJURV9HUkFQSF9TVEFUUyBzaG91bGQg
Y29udHJvbCBhbGwgc3RhdHMsIGluY2wuIHRvdGFsX2NhbGxzIGFuZCB0b3RhbF9vYmpzLg0KVGhl
biwgaWYgZW5hYmxlZCwgdGhlIHRvdGFsX2N5Y2xlcyBzdGF0cyBjYW4gYmUgY29udHJvbGxlZCBi
eSBydGVfZ3JhcGhfY3ljbGVfc3RhdHNfZW5hYmxlKCkuDQoNCllvdXIgdjEgc2VyaWVzIGludHJv
ZHVjZXMgdW5uZWNlc3Nhcnkgb3ZlcmhlYWQgZm9yIGFwcGxpY2F0aW9ucyBub3QgY2FyaW5nIGFi
b3V0IHRvdGFsX2NhbGxzL3RvdGFsX29ianMgc3RhdHMgYW5kIHRodXMgYnVpbHQgd2l0aG91dCBS
VEVfTElCUlRFX0dSQVBIX1NUQVRTLg0KDQo=
