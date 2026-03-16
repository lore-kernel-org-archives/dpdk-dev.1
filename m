Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A94EFCBD4
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 08:03:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9089D4025E;
	Mon, 16 Mar 2026 09:03:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 83C81400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 09:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773648209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2u6+DkD7PeZtVAJvF5Q6n9XV3srCIIQlaz091TdsaHw=;
 b=bBiNCLb/RCAvmqCfW54soI3z64nVtEXtOAUpy7Ko8QanvtmKz+yieFQirKSP84J10r+zn/
 WK90fY78kb4XpCszvGMDY/MfmRzEvcMSQrtKVzg917IHEUI4Zl5lXqUd0lSk3c17fPQoiT
 44lBz/f+chQXHSdSHm+lDxihg0b5igw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-fVelPY4QNJ6UCIE5LMVyDA-1; Mon, 16 Mar 2026 04:03:26 -0400
X-MC-Unique: fVelPY4QNJ6UCIE5LMVyDA-1
X-Mimecast-MFC-AGG-ID: fVelPY4QNJ6UCIE5LMVyDA_1773648205
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-38a39047762so20550521fa.3
 for <dev@dpdk.org>; Mon, 16 Mar 2026 01:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773648205; x=1774253005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2u6+DkD7PeZtVAJvF5Q6n9XV3srCIIQlaz091TdsaHw=;
 b=BFF9NWsZ8C4YNbr8IyDe6P0SNUbuFhEPfvbQ28uqoj1WPnfiRJrCY+MLFVipbOuuB/
 PpF6cSSSEXhS1RmnrcdXD+PNOSQQyKHMEftGVGfkcjwOUt4v4/yRiSfNlpyPKEF6f1Os
 ASU1oBSbRTmqFCYTs8yihKoxt/X+KTbk9NRzFpCU5DMKjzjW6F8xwrqh/tsbsxkPNRl6
 7neI/aibXht1AOyE4sPaT/0IQnEvwahPdiWJmiUYpOTBrSmw9Jg/eFgr2CezjxKRkfcO
 H6K7zgZtD2fUZ08gB/Evo4h/4jMsDe1Wy3nKEXtiTz41Y9ZmwD1TJW/gfsk0d/hyRfsw
 wQZA==
X-Gm-Message-State: AOJu0YzPmh2jOFYAxtrg4fwFRY2pZykKKv2Nex9/M9DpstEiWzLnMuNZ
 zI3KPGQxlPfc/g/3LR4+1N1WPvV8FZKyxaF4zFGAxVVXy1oS5eswPLAsyGQfohM+o0qqAL3bPJf
 rFRbgb0eABgESG5o/7bgJYdYfWHsyELiivpd5ZIU075UklCa4d73oRUkElu0oorhZTtj5x6xHtZ
 7trLLPeilafq19b1ZtIHM=
X-Gm-Gg: ATEYQzzBBDDoX0wJs/QT6J+r1HmRaa2g0K28kjm5OtnvZ//CA9zLHdV1q7pgvP6fGzw
 90Z2ESeRUbmndXgdGMjqNEfUIpa3TyfzpJD8XVSE0fmVz2apHhldtluK1s09et2E4PC/y8/Tkfv
 dbElIm84QSagsvXO5UvV0Gaa+xXIv7ePiw5vknMnJ/yJFuKjihAALR50goI8itbs1arLnMcvLQl
 nxwzTpWxlKBDueOGWSZe+R+dBJ6tdm0J6WjYL5TLe4MEa+d4Ua/Q0VcsVXUafyM13eSIw==
X-Received: by 2002:a2e:86d9:0:b0:38a:45e7:17df with SMTP id
 38308e7fff4ca-38a8966bf9cmr33908831fa.1.1773648204736; 
 Mon, 16 Mar 2026 01:03:24 -0700 (PDT)
X-Received: by 2002:a2e:86d9:0:b0:38a:45e7:17df with SMTP id
 38308e7fff4ca-38a8966bf9cmr33908731fa.1.1773648204237; Mon, 16 Mar 2026
 01:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
 <20260222173225.522754-20-stephen@networkplumber.org>
In-Reply-To: <20260222173225.522754-20-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Mar 2026 09:03:11 +0100
X-Gm-Features: AaiRm52n1xrUvnbamlmDfLcpKRwWb7YVnfZK4BLO726xDnEGEn8jvf02FJCSBto
Message-ID: <CAJFAV8ybKr-am3MONkg78SsE9vzk6+tiT0=i-kK2=x=FfLmoKA@mail.gmail.com>
Subject: Re: [PATCH v5 19/19] test: add unit tests for TAP PMD
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Luca Boccassi <luca.boccassi@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kJ790c56y_Dp9aB9_GX3VYgxAsL06icG8gpuG5whH00_1773648205
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
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

SGVsbG8gU3RlcGhlbiwNCg0KT24gU3VuLCAyMiBGZWIgMjAyNiBhdCAxODozNCwgU3RlcGhlbiBI
ZW1taW5nZXINCjxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4gd3JvdGU6DQo+DQo+IEFkZCBh
IHN0YW5kYWxvbmUgdGVzdCBzdWl0ZSBmb3IgdGhlIFRBUCBQTUQsIG1vZGVsZWQgb24gdGhlIGV4
aXN0aW5nDQo+IHRlc3RfcG1kX3JpbmcgdGVzdHMuIEV4ZXJjaXNlcyBkZXZpY2UgY29uZmlndXJh
dGlvbiwgbGluayBzdGF0dXMsDQo+IHN0YXRzLCBNVFUsIE1BQyBhZGRyZXNzLCBwcm9taXNjdW91
cy9hbGxtdWx0aWNhc3QgbW9kZXMsIHF1ZXVlDQo+IHN0YXJ0L3N0b3AsIGxpbmsgdXAvZG93biwg
ZGV2aWNlIHN0b3Avc3RhcnQsIGFuZCBtdWx0aS1xdWV1ZSBzZXR1cC4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KDQpU
aGlzIG5ldyB0ZXN0IHRyaWdnZXJzIGZhaWx1cmVzIGluIE9CUzoNCg0KWyAgMzczc10gIDc0LzEw
NyBEUERLOmZhc3QtdGVzdHMgLyB0YXBfcG1kX2F1dG90ZXN0DQogICAgIFJVTk5JTkcNClsgIDM3
M3NdID4+PiBMRF9MSUJSQVJZX1BBVEg9L3Vzci9zcmMvcGFja2FnZXMvQlVJTEQvb2JqLXg4Nl82
NC1saW51eC1nbnUvbGliOi91c3Ivc3JjL3BhY2thZ2VzL0JVSUxEL29iai14ODZfNjQtbGludXgt
Z251L2RyaXZlcnMNCk1BTExPQ19QRVJUVVJCXz01MiBEUERLX1RFU1Q9dGFwX3BtZF9hdXRvdGVz
dA0KL3Vzci9zcmMvcGFja2FnZXMvQlVJTEQvb2JqLXg4Nl82NC1saW51eC1nbnUvYXBwL2RwZGst
dGVzdCAtLW5vLWh1Z2UNCi1tIDIwNDggLWQgL3Vzci9zcmMvcGFja2FnZXMvQlVJTEQvb2JqLXg4
Nl82NC1saW51eC1nbnUvZHJpdmVycw0KWyAgMzczc10gw6LigqzigKLDouKCrOKAosOi4oKs4oCi
w6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLD
ouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi
4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6Li
gqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKC
rOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKINCsOixZPigqwgIMOi
4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6Li
gqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKC
rOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs
4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6Ligqzi
gKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKA
osOi4oKs4oCiDQpbICAzNzNzXSBFQUw6IERldGVjdGVkIENQVSBsY29yZXM6IDEyDQpbICAzNzNz
XSBFQUw6IERldGVjdGVkIE5VTUEgbm9kZXM6IDENClsgIDM3M3NdIEVBTDogRGV0ZWN0ZWQgc2hh
cmVkIGxpbmthZ2Ugb2YgRFBESw0KWyAgMzczc10gRUFMOiBNdWx0aS1wcm9jZXNzIHNvY2tldCAv
dG1wL2RwZGsvcnRlL21wX3NvY2tldA0KWyAgMzczc10gRUFMOiBTZWxlY3RlZCBJT1ZBIG1vZGUg
J1ZBJw0KWyAgMzczc10gQVBQOiBIUEVUIGlzIG5vdCBlbmFibGVkLCB1c2luZyBUU0MgYXMgZGVm
YXVsdCB0aW1lcg0KWyAgMzczc10gUlRFPj50YXBfcG1kX2F1dG90ZXN0DQpbICAzNzNzXSBUQVA6
IHR1bl9hbGxvYygpOiBVbmFibGUgdG8gb3BlbiAvZGV2L25ldC90dW4gaW50ZXJmYWNlDQpbICAz
NzNzXSBUQVA6IGV0aF9kZXZfdGFwX2NyZWF0ZSgpOiBVbmFibGUgdG8gY3JlYXRlIFRBUCBpbnRl
cmZhY2UNClsgIDM3M3NdIFRBUDogZXRoX2Rldl90YXBfY3JlYXRlKCk6IFRBUCBVbmFibGUgdG8g
aW5pdGlhbGl6ZSBuZXRfdGFwMA0KWyAgMzczc10gICsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSArDQpbICAzNzNzXSAgKyBUZXN0IFN1aXRl
IDogVEFQIFBNRCBVbml0IFRlc3QgU3VpdGUNClsgIDM3M3NdIFNldHRpbmcgdXAgVEFQIFBNRCB0
ZXN0DQpbICAzNzNzXSBFcnJvcjogZmFpbGVkIHRvIGNyZWF0ZSBUQVAgZGV2aWNlIG5ldF90YXAw
OiBJbnZhbGlkIGFyZ3VtZW50DQpbICAzNzNzXSAgKyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICsNClsgIDM3M3NdICArIFRlc3QgU3VpdGUg
U3VtbWFyeSA6IFRBUCBQTUQgVW5pdCBUZXN0IFN1aXRlDQpbICAzNzNzXSAgKyAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICsNClsgIDM3M3Nd
ICArIFRlc3RzIFRvdGFsIDogICAgICAgMTcNClsgIDM3M3NdICArIFRlc3RzIFNraXBwZWQgOiAg
ICAgIDANClsgIDM3M3NdICArIFRlc3RzIEV4ZWN1dGVkIDogICAgIDANClsgIDM3M3NdICArIFRl
c3RzIFVuc3VwcG9ydGVkOiAgIDANClsgIDM3M3NdICArIFRlc3RzIFBhc3NlZCA6ICAgICAgIDAN
ClsgIDM3M3NdICArIFRlc3RzIEZhaWxlZCA6ICAgICAgMTcNClsgIDM3M3NdICArIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKw0KWyAgMzcz
c10gVGVzdCBGYWlsZWQNClsgIDM3M3NdIFJURT4+w6LigqzigKLDouKCrOKAosOi4oKs4oCiw6Li
gqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKC
rOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs
4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6Ligqzi
gKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKA
osOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCi
w6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLD
ouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi
4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6Li
gqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKC
rOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiw6LigqzigKLDouKCrOKAosOi4oKs
4oCiw6LigqzigKLDouKCrOKAosOi4oKs4oCiDQpbICAzNzNzXSAgNzQvMTA3IERQREs6ZmFzdC10
ZXN0cyAvIHRhcF9wbWRfYXV0b3Rlc3QNCiAgICAgRkFJTCAgICAgICAgICAgIDAuMjNzICAgKGV4
aXQgc3RhdHVzIDI1NSBvciBzaWduYWwgMTI3DQpTSUdpbnZhbGlkKQ0KDQoNCi0tIA0KRGF2aWQg
TWFyY2hhbmQNCg==

