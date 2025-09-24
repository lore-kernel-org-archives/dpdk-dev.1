Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A83CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 02:55:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C8CA402E0;
	Wed, 24 Sep 2025 04:55:45 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 5B412402D8
 for <dev@dpdk.org>; Wed, 24 Sep 2025 04:55:43 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cWhL53j43z8Xs76;
 Wed, 24 Sep 2025 10:55:41 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
 by mse-fl2.zte.com.cn with SMTP id 58O2tU0u088405;
 Wed, 24 Sep 2025 10:55:30 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 24 Sep 2025 10:55:31 +0800
X-Zmail-TransId: 3e8168d35d9e006-b7e3d
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org
Subject: Re: [PATCH v1] net/zxdh: add support compiling on riscv-64 systems
Date: Wed, 24 Sep 2025 10:42:11 +0800
Message-ID: <20250924024211.27501-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911023211.3576860-1-wang.junlong1@zte.com.cn>
References: <20250911023211.3576860-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 58O2tU0u088405
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 24 Sep 2025 10:55:41 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68D35DAD.000/4cWhL53j43z8Xs76
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

PiA+IC1pZiBub3QgaXNfbGludXgNCj4gPiAraWYgbm90IGlzX2xpbnV4IG9yIG5vdCBkcGRrX2Nv
bmYuZ2V0KCdSVEVfQVJDSF82NCcpDQo+ID4gICAgICBidWlsZCA9IGZhbHNlDQo+ID4gLSAgICBy
ZWFzb24gPSAnb25seSBzdXBwb3J0ZWQgb24gTGludXgnDQo+ID4gLSAgICBzdWJkaXJfZG9uZSgp
DQo+ID4gLWVuZGlmDQo+ID4gLQ0KPiA+IC1pZiBhcmNoX3N1YmRpciAhPSAneDg2JyBhbmQgYXJj
aF9zdWJkaXIgIT0gJ2FybScgb3Igbm90IGRwZGtfY29uZi5nZXQoJ1JURV9BUkNIXzY0JykNCj4g
PiAtICAgIGJ1aWxkID0gZmFsc2UNCj4gPiAtICAgIHJlYXNvbiA9ICdvbmx5IHN1cHBvcnRlZCBv
biB4ODZfNjQgYW5kIGFhcmNoNjQnDQo+ID4gKyAgICByZWFzb24gPSAnb25seSBzdXBwb3J0ZWQg
b24gNjQtYml0IExpbnV4Jw0KPiA+ICAgICAgc3ViZGlyX2RvbmUoKQ0KDQo+IFRoZXJlIGlzIGFs
c28gcG93ZXJwYy4gRG8geW91IHRoaW5rIGl0IHdpbGwgY29tcGlsZT8NCg0KWWVzLCBpdCB3aWxs
LiBBbmQgdGhlIGNvbXBpbGF0aW9uIGlzIGZpbmUu


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Jmd0OyZuYnNwOyZndDsmbmJzcDstaWYmbmJzcDtub3QmbmJzcDtpc19saW51eDxiciAvPiZndDsm
bmJzcDsmZ3Q7Jm5ic3A7K2lmJm5ic3A7bm90Jm5ic3A7aXNfbGludXgmbmJzcDtvciZuYnNwO25v
dCZuYnNwO2RwZGtfY29uZi5nZXQoJmFwb3M7UlRFX0FSQ0hfNjQmYXBvczspPGJyIC8+Jmd0OyZu
YnNwOyZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtidWlsZCZuYnNwOz0m
bmJzcDtmYWxzZTxiciAvPiZndDsmbmJzcDsmZ3Q7Jm5ic3A7LSZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwO3JlYXNvbiZuYnNwOz0mbmJzcDsmYXBvcztvbmx5Jm5ic3A7c3VwcG9ydGVkJm5ic3A7b24m
bmJzcDtMaW51eCZhcG9zOw08YnIgLz4mZ3Q7Jm5ic3A7Jmd0OyZuYnNwOy0mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDtzdWJkaXJfZG9uZSgpPGJyIC8+Jmd0OyZuYnNwOyZndDsmbmJzcDstZW5kaWY8
YnIgLz4mZ3Q7Jm5ic3A7Jmd0OyZuYnNwOy08YnIgLz4mZ3Q7Jm5ic3A7Jmd0OyZuYnNwOy1pZiZu
YnNwO2FyY2hfc3ViZGlyJm5ic3A7IT0mbmJzcDsmYXBvczt4ODYmYXBvczsmbmJzcDthbmQmbmJz
cDthcmNoX3N1YmRpciZuYnNwOyE9Jm5ic3A7JmFwb3M7YXJtJmFwb3M7Jm5ic3A7b3ImbmJzcDtu
b3QmbmJzcDtkcGRrX2NvbmYuZ2V0KCZhcG9zO1JURV9BUkNIXzY0JmFwb3M7KTxiciAvPiZndDsm
bmJzcDsmZ3Q7Jm5ic3A7LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2J1aWxkJm5ic3A7PSZuYnNw
O2ZhbHNlPGJyIC8+Jmd0OyZuYnNwOyZndDsmbmJzcDstJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
cmVhc29uJm5ic3A7PSZuYnNwOyZhcG9zO29ubHkmbmJzcDtzdXBwb3J0ZWQmbmJzcDtvbiZuYnNw
O3g4Nl82NCZuYnNwO2FuZCZuYnNwO2FhcmNoNjQmYXBvczsNPGJyIC8+Jmd0OyZuYnNwOyZndDsm
bmJzcDsrJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7cmVhc29uJm5ic3A7PSZuYnNwOyZhcG9zO29u
bHkmbmJzcDtzdXBwb3J0ZWQmbmJzcDtvbiZuYnNwOzY0LWJpdCZuYnNwO0xpbnV4JmFwb3M7DTxi
ciAvPiZndDsmbmJzcDsmZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7c3Vi
ZGlyX2RvbmUoKTxiciAvPg08YnIgLz4mZ3Q7Jm5ic3A7VGhlcmUmbmJzcDtpcyZuYnNwO2Fsc28m
bmJzcDtwb3dlcnBjLiZuYnNwO0RvJm5ic3A7eW91Jm5ic3A7dGhpbmsmbmJzcDtpdCZuYnNwO3dp
bGwmbmJzcDtjb21waWxlPzxiciAvPg08YnIgLz5ZZXMsJm5ic3A7aXQmbmJzcDt3aWxsLiZuYnNw
O0FuZCZuYnNwO3RoZSZuYnNwO2NvbXBpbGF0aW9uJm5ic3A7aXMmbmJzcDtmaW5lLjxiciAvPg==

--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

