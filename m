Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A6C35FFF
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 06:28:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DA694066F;
	Fri, 21 Mar 2025 07:28:49 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2708940276;
 Fri, 21 Mar 2025 07:28:48 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D206320582;
 Fri, 21 Mar 2025 07:28:47 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: Clarification on Minimum Supported Kernel Version for DPDK
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 21 Mar 2025 07:28:45 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB37@smartserver.smartshare.dk>
In-Reply-To: <CAMEVEZvCoVpMjFpmY29-x0zB2tQvNrJsTacs6-Zzx4jJB_GsoQ@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Clarification on Minimum Supported Kernel Version for DPDK
Thread-Index: AduZ1ooPUv6HLU1RQ+WsttYMKXLXQQAUG1Hw
References: <CAMEVEZvCoVpMjFpmY29-x0zB2tQvNrJsTacs6-Zzx4jJB_GsoQ@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Cody Cheng" <ccheng@iol.unh.edu>, "Kevin Traynor" <ktraynor@redhat.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <techboard@dpdk.org>, "Tyler Retzlaff" <roretzla@linux.microsoft.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>,
 "Ali Alnubani" <alialnu@nvidia.com>, <galco@nvidia.com>
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

QEtldmluLCBAU3RlcGhlbiwgQEJydWNlLA0KDQpJIGNhbm5vdCByZWxpYWJseSBhbnN3ZXIgQ29k
eSdzIHF1ZXN0aW9uLCBhbmQgaXQgbWF5IG5lZWQgZnVydGhlciBkaXNjdXNzaW9uLg0KDQpXaGF0
IGlzIHlvdXIgb3BpbmlvbiBvbiBtaW5pbXVtIExpbnV4IGtlcm5lbCB2ZXJzaW9uIHJlcXVpcmVt
ZW50cz8NCg0KQFRob21hczogSW4gdGhlIGZ1dHVyZSwgdGhlIERQREsgcmVsZWFzZSBub3RlcyBz
aG91bGQgbWVudGlvbiB0aGUgbWluaW11bSBMaW51eCBrZXJuZWwgcmVxdWlyZW1lbnRzLg0KDQo+
IEZyb206IENvZHkgQ2hlbmcgW21haWx0bzpjY2hlbmdAaW9sLnVuaC5lZHVdDQo+IFNlbnQ6IFRo
dXJzZGF5LCAyMCBNYXJjaCAyMDI1IDIxLjI4DQo+IA0KPiBIaSBNb3J0ZW4sDQo+IA0KPiBJIGFt
IGluIHRoZSBwcm9jZXNzIG9mIHNldHRpbmcgdXAgYSB0ZXN0IGVudmlyb25tZW50IGF0IHRoZSBV
TkggRFBESw0KPiBDb21tdW5pdHkgVGVzdCBMYWIgdGhhdCBmb2xsb3dzIHRoZSBtaW5pbXVtIHN1
cHBvcnRlZCBrZXJuZWwgdmVyc2lvbg0KPiBmb3IgRFBESy4gQWNjb3JkaW5nIHRvIHRoZSBEUERL
IGRvY3VtZW50YXRpb24sIHRoZSBtaW5pbXVtIHN1cHBvcnRlZA0KPiBrZXJuZWwgdmVyc2lvbiBp
cyA0LjE5LiBIb3dldmVyLCB0aGUgb2xkZXN0IGxvbmcgdGVybSBzdGFibGUga2VybmVsDQo+IHZl
cnNpb24gbGlzdGVkIG9uIGtlcm5lbC5vcmcgaXMgNS40LjI5MS4NCj4gDQo+IFNob3VsZCB0aGUg
dGVzdCBlbnZpcm9ubWVudCBiZSBzZXQgdXAgb24ga2VybmVsIHZlcnNpb24gNC4xOSBvcg0KPiA1
LjQuMjkxPw0KDQpUaGUga2VybmVsIDQuMTkgc3VwcG9ydCBzdGVtcyBmcm9tIHN0aWxsIHN1cHBv
cnRpbmcgUkhFTC9DZW50T1MgNy4NCkkgd29uZGVyIGlmIHRoaXMgZXhjZXB0aW9uIG1lbnRpb25l
ZCBpbiB0aGUgZG9jdW1lbnRhdGlvbiBbMV0gaXMgc3RpbGwgdmFsaWQsIG9yIGlmIHdlIHNob3Vs
ZCBidW1wIGl0IHRvIFJIRUwvQ2VudE9TIDgsIHdoaWNoIHNoaXBzIHdpdGgga2VybmVsIDQuMTgg
WzFdLg0KDQpSSEVML0NlbnRPUyA3IHN1cHBvcnQgd2FzIGRpc2N1c3NlZCBhdCBieSB0ZWNoIGJv
YXJkIGxvbmcgYWdvIFsyXSwgYnV0IEkgY2Fubm90IGZpbmQgYSBjb25jbHVzaW9uIGFib3V0IHRo
ZSBrZXJuZWwgdmVyc2lvbjsgdGhlIGRpc2N1c3Npb24gd2FzIG1vc3RseSBhYm91dCBjb21waWxl
ciBzdXBwb3J0Lg0KDQpbMV06IGh0dHBzOi8vZG9jLmRwZGsub3JnL2d1aWRlcy9saW51eF9nc2cv
c3lzX3JlcXMuaHRtbCNzeXN0ZW0tc29mdHdhcmUNClsyXTogaHR0cHM6Ly9kb2NzLnJlZGhhdC5j
b20vZW4vZG9jdW1lbnRhdGlvbi9yZWRfaGF0X2VudGVycHJpc2VfbGludXgvOC9odG1sLXNpbmds
ZS84LjBfcmVsZWFzZV9ub3Rlcy9pbmRleCNvdmVydmlldw0KWzNdOiBodHRwczovL21haWxzLmRw
ZGsub3JnL2FyY2hpdmVzL2Rldi8yMDIzLUZlYnJ1YXJ5LzI2MzUxNi5odG1sDQoNCg0KPiANCj4g
VGhhbmtzLA0KPiBDb2R5IENoZW5nDQo+IFVOSCBEUERLIENvbW11bml0eSBUZXN0IExhYg0KDQo=
