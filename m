Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FB7CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 06:53:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85F26402C4;
	Tue,  2 Jun 2026 08:53:44 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CFB1C40150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 08:53:43 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9ED45208EE
 for <dev@dpdk.org>; Tue,  2 Jun 2026 08:53:43 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v7] mempool/dpaa2: update for new mempool cache algorithm
Date: Tue, 2 Jun 2026 08:53:42 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658D2@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260601183621.252920-3-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7] mempool/dpaa2: update for new mempool cache algorithm
Thread-Index: Adzx9Yx9me14TJoTRhu4OwXUz+sO7wAZsxWw
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260601183621.252920-1-mb@smartsharesystems.com>
 <20260601183621.252920-3-mb@smartsharesystems.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
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

UmVjaGVjay1yZXF1ZXN0OiBpb2wtdW5pdC1hcm02NC10ZXN0aW5nDQoNCkNJIHN1YnN5c3RlbSBs
b2c6DQo9PT09IDIwIGxpbmUgbG9nIG91dHB1dCBmb3IgVWJ1bnR1IDI0LjA0IChscG1fYXV0b3Rl
c3QpOiA9PT09DQpbLi4uXQ0KWzg5LzQwNl0gQ29tcGlsaW5nIEMgb2JqZWN0IGxpYi9saWJydGVf
ZWFsLmEucC9lYWxfbGludXhfZWFsX3RpbWVyLmMubw0KRkFJTEVEOiBsaWIvbGlicnRlX2VhbC5h
LnAvZWFsX2xpbnV4X2VhbF90aW1lci5jLm8NCmdjYy0xMCAtSWxpYi9saWJydGVfZWFsLmEucCAt
SWxpYiAtSS4uL2xpYiAtSWxpYi9lYWwvY29tbW9uIC1JLi4vbGliL2VhbC9jb21tb24gLUkuIC1J
Li4gLUljb25maWcgLUkuLi9jb25maWcgLUlsaWIvZWFsL2luY2x1ZGUgLUkuLi9saWIvZWFsL2lu
Y2x1ZGUgLUlsaWIvZWFsL2xpbnV4L2luY2x1ZGUgLUkuLi9saWIvZWFsL2xpbnV4L2luY2x1ZGUg
LUlsaWIvZWFsL2FybS9pbmNsdWRlIC1JLi4vbGliL2VhbC9hcm0vaW5jbHVkZSAtSS4uL2tlcm5l
bC9saW51eCAtSWxpYi9lYWwgLUkuLi9saWIvZWFsIC1JbGliL2t2YXJncyAtSS4uL2xpYi9rdmFy
Z3MgLUlsaWIvbG9nIC1JLi4vbGliL2xvZyAtSS4uL2xpYi9tZXRyaWNzIC1JbGliL3RlbGVtZXRy
eSAtSS4uL2xpYi90ZWxlbWV0cnkgLUlsaWIvYXJncGFyc2UgLUkuLi9saWIvYXJncGFyc2UgLWZk
aWFnbm9zdGljcy1jb2xvcj1hbHdheXMgLXBpcGUgLURfRklMRV9PRkZTRVRfQklUUz02NCAtV2Fs
bCAtV2ludmFsaWQtcGNoIC1XZXh0cmEgLVdlcnJvciAtc3RkPWMxMSAtTzMgLWluY2x1ZGUgcnRl
X2NvbmZpZy5oIC1XdmxhIC1XY2FzdC1xdWFsIC1XZGVwcmVjYXRlZCAtV2Zvcm1hdCAtV2Zvcm1h
dC1ub25saXRlcmFsIC1XZm9ybWF0LXNlY3VyaXR5IC1XbWlzc2luZy1kZWNsYXJhdGlvbnMgLVdt
aXNzaW5nLXByb3RvdHlwZXMgLVduZXN0ZWQtZXh0ZXJucyAtV29sZC1zdHlsZS1kZWZpbml0aW9u
IC1XcG9pbnRlci1hcml0aCAtV3NoYWRvdyAtV3NpZ24tY29tcGFyZSAtV3N0cmljdC1wcm90b3R5
cGVzIC1XdW5kZWYgLVd3cml0ZS1zdHJpbmdzIC1Xbm8tcGFja2VkLW5vdC1hbGlnbmVkIC1Xbm8t
bWlzc2luZy1maWVsZC1pbml0aWFsaXplcnMgLURfR05VX1NPVVJDRSAtZlBJQyAtbWFyY2g9YXJt
djguMi1hK2NyeXB0bytzdmUgLURBTExPV19FWFBFUklNRU5UQUxfQVBJIC1EQUxMT1dfSU5URVJO
QUxfQVBJICctREFCSV9WRVJTSU9OPSIyNi4yIicgLURSVEVfTE9HX0RFRkFVTFRfTE9HVFlQRT1s
DQogaWIuZWFsIC1NRCAtTVEgbGliL2xpYnJ0ZV9lYWwuYS5wL2VhbF9saW51eF9lYWxfdGltZXIu
Yy5vIC1NRiBsaWIvbGlicnRlX2VhbC5hLnAvZWFsX2xpbnV4X2VhbF90aW1lci5jLm8uZCAtbyBs
aWIvbGlicnRlX2VhbC5hLnAvZWFsX2xpbnV4X2VhbF90aW1lci5jLm8gLWMgLi4vbGliL2VhbC9s
aW51eC9lYWxfdGltZXIuYw0KZ2NjLTEwOiBpbnRlcm5hbCBjb21waWxlciBlcnJvcjogU2VnbWVu
dGF0aW9uIGZhdWx0IHNpZ25hbCB0ZXJtaW5hdGVkIHByb2dyYW0gY2MxDQpQbGVhc2Ugc3VibWl0
IGEgZnVsbCBidWcgcmVwb3J0LA0Kd2l0aCBwcmVwcm9jZXNzZWQgc291cmNlIGlmIGFwcHJvcHJp
YXRlLg0KU2VlIDxmaWxlOi8vL3Vzci9zaGFyZS9kb2MvZ2NjLTEwL1JFQURNRS5CdWdzPiBmb3Ig
aW5zdHJ1Y3Rpb25zLg0KDQo=
