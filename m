Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94169EDF03F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 05:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE5CD402EA;
	Thu, 12 Feb 2026 06:45:32 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 9EA914025F
 for <dev@dpdk.org>; Thu, 12 Feb 2026 06:45:30 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61C5jRhuD3342980,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770875128;
 bh=NR3crC9ImNxzo6EuHnX7jEbT4fcG4Mx8REru+5FiPFM=;
 h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=fh20UszpEaM6F6JvntXiRWpqcay18hzUXboN34O4ZOvOzLbJL5bDai33A1dhXZfUU
 KMGYgu6QzKL9LPnPtzY/vO5xFTNSWkNlBaLbNbfgbYig1JrHCo+NnQ4tnH69TiryyA
 Cx89T+dEs71Ja8SK3a/qpo1dDe50+bNqScjr5CbqiboCEZXBmr5QdHAEZkZ0jUEuos
 Pq3qXY8zUt0OsmD1cZ+RlDUuoJ+0T5ga5ykSFscLRjMCY4AqcYsl2RCOoNVRjLrRfa
 rVX09PInOSwKqgdaaE/HfokNNtDhdpzYh0pSaWxCdG0bC9Hc8FiNv4/8cE4rHi6l1p
 CqnvYRvh5sqBw==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61C5jRhuD3342980
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Feb 2026 13:45:28 +0800
Received: from RS-EX-MBS4.realsil.com.cn (172.29.17.104) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 12 Feb 2026 13:45:27 +0800
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104]) by
 RS-EX-MBS4.realsil.com.cn ([172.29.17.104]) with mapi id 15.02.1748.039; Thu,
 12 Feb 2026 13:45:27 +0800
From: =?gb2312?B?zfXyqw==?= <howard_wang@realsil.com.cn>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pro_nic_dpdk@realtek.com"
 <pro_nic_dpdk@realtek.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMDIvMTJdIG5ldC9yODE2OTogdHVuZSBSWCBkZXNjIGZldGNoIG51bSBmb3IgODEyNiBhbmQgODEyNw==?=
Thread-Topic: [PATCH v2 02/12] net/r8169: tune RX desc fetch num for 8126 and
 8127
Thread-Index: AQHcmlHUwkXtbDc59020tQricz/2obV9hCcAgAEKVfA=
Date: Thu, 12 Feb 2026 05:45:27 +0000
Message-ID: <53eab1bb8691493e88b439f73823a8b9@realsil.com.cn>
References: <20260210055511.62382-1-howard_wang@realsil.com.cn>
 <20260210055511.62382-3-howard_wang@realsil.com.cn>
 <20260211134326.61146e31@phoenix.local>
In-Reply-To: <20260211134326.61146e31@phoenix.local>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
x-originating-ip: [172.29.17.210]
Content-Type: text/plain; charset="gb2312"
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

T0ssIEkgd2lsbCBhZGQgdGhlc2UgZXhwbGFuYXRpb25zIHRvIHRoZSBjb21taXQgbG9nIGluIHYz
Lg0KDQpUaGUgZGVmYXVsdCB2YWx1ZXMgaW4gdGhlIExpbnV4IGRyaXZlciBhcmUgYWN0dWFsbHkg
dGhlIG9uZXMgYmVmb3JlIHRoaXMgbW9kaWZpY2F0aW9uLg0KVGhpcyBwYXJhbWV0ZXIgY29udHJv
bHMgdGhlIG51bWJlciBvZiBSWCBkZXNjcmlwdG9ycyBmZXRjaGVkIGluIGEgc2luZ2xlIGJhdGNo
LiBUdW5pbmcgdGhpcyB2YWx1ZSBvcHRpbWl6ZXMgdGhlIFJYIHBlcmZvcm1hbmNlLg0KUmVnYXJk
aW5nIHJ0ZV9ldGhfZGV2X2luZm8gYW5kIHJ0ZV9ldGhfcnhjb25mLCBJIGNoZWNrZWQgdGhlIHN0
cnVjdHVyZXMgYW5kIHRoZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSBhIHJlbGV2YW50IGdlbmVyaWMg
dmFyaWFibGUgdGhhdCBtYXBzIHRvIHRoaXMgc3BlY2lmaWMgaGFyZHdhcmUgcGFyYW1ldGVyLg0K
DQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5A
bmV0d29ya3BsdW1iZXIub3JnPiANCreiy83KsbzkOiAyMDI2xOoy1MIxMsjVIDU6NDMNCsrVvP7I
yzogzfXyqyA8aG93YXJkX3dhbmdAcmVhbHNpbC5jb20uY24+DQqzrcvNOiBkZXZAZHBkay5vcmc7
IHByb19uaWNfZHBka0ByZWFsdGVrLmNvbQ0K1vfM4jogUmU6IFtQQVRDSCB2MiAwMi8xMl0gbmV0
L3I4MTY5OiB0dW5lIFJYIGRlc2MgZmV0Y2ggbnVtIGZvciA4MTI2IGFuZCA4MTI3DQoNCg0KRXh0
ZXJuYWwgbWFpbCA6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgdGhlIG9yZ2Fu
aXphdGlvbi4gRG8gbm90IHJlcGx5LCBjbGljayBsaW5rcywgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUuDQoNCg0KDQpPbiBUdWUsIDEwIEZlYiAyMDI2IDEzOjU1OjAxICswODAwDQpIb3dhcmQgV2Fu
ZyA8aG93YXJkX3dhbmdAcmVhbHNpbC5jb20uY24+IHdyb3RlOg0KDQo+IEZvciBSVEw4MTI2OiBU
dW5lIFJYIGRlc2NyaXB0b3IgZmV0Y2ggbnVtYmVyIHRvIDIwLg0KPiBGb3IgUlRMODEyNzogVHVu
ZSBSWCBkZXNjcmlwdG9yIGZldGNoIG51bWJlciB0byAxMi4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
SG93YXJkIFdhbmcgPGhvd2FyZF93YW5nQHJlYWxzaWwuY29tLmNuPg0KPiAtLS0NCg0KSXQgd291
bGQgYmUgZ29vZCB0byBoYXZlIHNvbWUgZXhwbGFuYXRpb25zIG9mIHRoZXNlLg0KQXJlIHRoZXNl
IHRoZSBkZWZhdWx0cyBpbiBvdGhlciBPUydzPw0KDQpFdmVuIGJldHRlciB3b3VsZCBiZSB0byBp
bnRlZ3JhdGUgdGhlbSBpbnRvIHRoZSBleGlzdGluZyBEUERLIHJ0ZV9ldGhfdGhyZXNoIHZhbHVl
cyB0aGF0IGFyZSBwYXNzZWQgaW4gdmlhIHJ0ZV9ldGhfcnhjb25mIGFuZCByZXR1cm5lZCB3aXRo
IHJ0ZV9ldGhfZGV2X2luZm8uDQo=
