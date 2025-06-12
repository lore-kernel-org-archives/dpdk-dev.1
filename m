Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDED4C71135
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 01:24:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 796C54021F;
	Thu, 12 Jun 2025 03:24:26 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 22C1140156
 for <dev@dpdk.org>; Thu, 12 Jun 2025 03:24:24 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bHlDj2mM7z8RVFF;
 Thu, 12 Jun 2025 09:24:21 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl1.zte.com.cn with SMTP id 55C1O5mu079311;
 Thu, 12 Jun 2025 09:24:05 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 12 Jun 2025 09:24:06 +0800
X-Zmail-TransId: 3e81684a2c31007-db6be
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: thomas@monjalon.net, stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 1/3] net/zxdh: modify some MAC config issues
Date: Thu, 12 Jun 2025 09:18:50 +0800
Message-ID: <20250612011850.3304706-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607023020.3051575-1-wang.junlong1@zte.com.cn>
References: <20250607023020.3051575-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 55C1O5mu079311
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 684A2C45.000/4bHlDj2mM7z8RVFF
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



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Pj4gbW9kaWZ5IHNvbWUgbWFjIGNvbmZpZyBpc3N1ZXMsDQo+PiB3aGljaCB3ZXJlIGRpc2NvdmVy
ZWQgZHVyaW5nIHRoZSB0ZXN0aW5nIHByb2Nlc3MuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEp1
bmxvbmcgV2FuZyA8d2FuZy5qdW5sb25nMUB6dGUuY29tLmNuPg0KDQo+IFRoYXQncyBub3QgaG93
IHdlIGZpeCBpc3N1ZXMgaW4gZ2VuZXJhbCBpbiBEUERLLg0KPiBXZSB3YW50IHRvIHByb3ZpZGUg
dHJhY2tpbmcgaGlzdG9yeSwgc286DQo+IC0gd2Ugc3BsaXQgdGhlIGZpeGVzIHBlciBpc3N1ZQ0K
PiAtIHdlIHByb3ZpZGUgdGhlIGNhdXNlIG9yaWdpbiAod2l0aCAiRml4ZXM6IiBsaW5lKQ0KPg0K
PiBQbGVhc2UgY291bGQgc3BsaXQgYW5kIGJldHRlciBjb21tZW50IHRoZXNlIGZpeGVzPw0KPiBU
aGFua3MNCg0KDQpPa2F5LCBJIHdpbGwgcmV2aXNlIGFuZCByZXN1Ym1pdCBpdCBzcGxpdCBhbmQg
YmV0dGVyIGNvbW1lbnQgdGhlc2UgZml4ZXMuIA0KYnV0IHRoaXMgc2VyaWVzIHBhdGNoIHN0YXR1
cyBpcyBBd2FpdGluZyBVcHN0cmVhbSwgDQpkbyBJIG5lZWQgdG8gbW9kaWZ5IHRoZSBzdGF0dXMg
Zm9yIHJvbGxiYWNrLg==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Jmd0OyZndDsmbmJzcDttb2RpZnkmbmJzcDtzb21lJm5ic3A7bWFjJm5ic3A7Y29uZmlnJm5ic3A7
aXNzdWVzLDxiciAvPiZndDsmZ3Q7Jm5ic3A7d2hpY2gmbmJzcDt3ZXJlJm5ic3A7ZGlzY292ZXJl
ZCZuYnNwO2R1cmluZyZuYnNwO3RoZSZuYnNwO3Rlc3RpbmcmbmJzcDtwcm9jZXNzLjxiciAvPiZn
dDsmZ3Q7Jm5ic3A7DTxiciAvPiZndDsmZ3Q7Jm5ic3A7U2lnbmVkLW9mZi1ieTombmJzcDtKdW5s
b25nJm5ic3A7V2FuZyZuYnNwOyZsdDt3YW5nLmp1bmxvbmcxQHp0ZS5jb20uY24mZ3Q7DTxiciAv
Pg08YnIgLz4mZ3Q7Jm5ic3A7VGhhdCZhcG9zO3MmbmJzcDtub3QmbmJzcDtob3cmbmJzcDt3ZSZu
YnNwO2ZpeCZuYnNwO2lzc3VlcyZuYnNwO2luJm5ic3A7Z2VuZXJhbCZuYnNwO2luJm5ic3A7RFBE
Sy48YnIgLz4mZ3Q7Jm5ic3A7V2UmbmJzcDt3YW50Jm5ic3A7dG8mbmJzcDtwcm92aWRlJm5ic3A7
dHJhY2tpbmcmbmJzcDtoaXN0b3J5LCZuYnNwO3NvOjxiciAvPiZndDsmbmJzcDstJm5ic3A7d2Um
bmJzcDtzcGxpdCZuYnNwO3RoZSZuYnNwO2ZpeGVzJm5ic3A7cGVyJm5ic3A7aXNzdWU8YnIgLz4m
Z3Q7Jm5ic3A7LSZuYnNwO3dlJm5ic3A7cHJvdmlkZSZuYnNwO3RoZSZuYnNwO2NhdXNlJm5ic3A7
b3JpZ2luJm5ic3A7KHdpdGgmbmJzcDsmcXVvdDtGaXhlczomcXVvdDsmbmJzcDtsaW5lKTxiciAv
PiZndDsNPGJyIC8+Jmd0OyZuYnNwO1BsZWFzZSZuYnNwO2NvdWxkJm5ic3A7c3BsaXQmbmJzcDth
bmQmbmJzcDtiZXR0ZXImbmJzcDtjb21tZW50Jm5ic3A7dGhlc2UmbmJzcDtmaXhlcz88YnIgLz4m
Z3Q7Jm5ic3A7VGhhbmtzPGJyIC8+DTxiciAvPg08YnIgLz5Pa2F5LCZuYnNwO0kmbmJzcDt3aWxs
Jm5ic3A7cmV2aXNlJm5ic3A7YW5kJm5ic3A7cmVzdWJtaXQmbmJzcDtpdCZuYnNwO3NwbGl0Jm5i
c3A7YW5kJm5ic3A7YmV0dGVyJm5ic3A7Y29tbWVudCZuYnNwO3RoZXNlJm5ic3A7Zml4ZXMuJm5i
c3A7DTxiciAvPmJ1dCZuYnNwO3RoaXMmbmJzcDtzZXJpZXMmbmJzcDtwYXRjaCZuYnNwO3N0YXR1
cyZuYnNwO2lzJm5ic3A7QXdhaXRpbmcmbmJzcDtVcHN0cmVhbSwmbmJzcDsNPGJyIC8+ZG8mbmJz
cDtJJm5ic3A7bmVlZCZuYnNwO3RvJm5ic3A7bW9kaWZ5Jm5ic3A7dGhlJm5ic3A7c3RhdHVzJm5i
c3A7Zm9yJm5ic3A7cm9sbGJhY2suPGJyIC8+DTxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

