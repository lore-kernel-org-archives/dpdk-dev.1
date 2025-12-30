Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38552E94109
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 08:32:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97EA8402BD;
	Tue, 30 Dec 2025 09:32:53 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTP id 80475402BC
 for <dev@dpdk.org>; Tue, 30 Dec 2025 09:32:52 +0100 (CET)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dgRDM0rF2z6FyCJ;
 Tue, 30 Dec 2025 16:32:51 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl2.zte.com.cn with SMTP id 5BU8WTDH088608;
 Tue, 30 Dec 2025 16:32:29 +0800 (+08)
 (envelope-from zhang.tianhao2@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Tue, 30 Dec 2025 16:32:31 +0800
X-Zmail-TransId: 3e8169538e10000-eb73b
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: zhang.tianhao2@zte.com.cn
From: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Subject: [PATCH v2 0/2] fix npsdk bug
Date: Tue, 30 Dec 2025 16:11:25 +0800
Message-ID: <20251230081127.813605-1-zhang.tianhao2@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222102535.401064-2-zhang.tianhao2@zte.com.cn>
References: <20251222102535.401064-2-zhang.tianhao2@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 5BU8WTDH088608
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.tianhao2@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 30 Dec 2025 16:32:51 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69538E33.001/4dgRDM0rF2z6FyCJ
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

VjI6DQogIC0gUmVzb2x2ZSBjb2RlIHN0eWxlDQogIC0gUHJvdmlkZSBjbGVhciBlcnJvciBtZXNz
YWdlcy4NCg0KVjE6DQogIC0gQWRkIG5ldyB0aW1lb3V0IGVycm9yIHJldHVybi4NCiAgLSBBZGQg
UENJZSBsaW5rIGhlYWx0aCBjaGVjay4NCiAgLSBSZW1vdmUgdGhlIE5QIHNvZnR3YXJlIHJlc291
cmNlIHVuaW5zdGFsbGF0aW9uIHByb2NlZHVyZSBmcm9tIHRoZSBOUCBvbmxpbmUgdW5pbml0IHBy
b2Nlc3MuIA0KICAtIE5QIHNvZnR3YXJlIHJlc291cmNlIHVuaW5zdGFsbGF0aW9uIHNob3VsZCBi
ZSBjYWxsZWQgc2VwYXJhdGVseSB3aXRoaW4gTlAgdW5pbml0IHRvIGF2b2lkIGR1cGxpY2F0ZSBy
ZXNvdXJjZSByZWxlYXNlLg0KDQpUaWFuaGFvIFpoYW5nICgyKToNCiAgbmV0L3p4ZGg6IGFkZCBw
Y2llIGJhciBjaGFubmVsIGNoZWNrDQogIG5ldC96eGRoOiBvcHRpbWl6ZSB0aGUgcHJvY2VkdXJl
IGZvciBOUCBvbmxpbmUgdW5pbml0DQoNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYyB8IDEy
ICsrKysrKystLS0tLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5oIHwgIDMgKysrDQogMiBm
aWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQotLSANCjIu
MjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjI6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO1Jlc29sdmUmbmJzcDtjb2RlJm5ic3A7c3R5bGU8
YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7UHJvdmlkZSZuYnNwO2NsZWFyJm5ic3A7ZXJyb3ImbmJz
cDttZXNzYWdlcy48YnIgLz4NPGJyIC8+VjE6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO0FkZCZu
YnNwO25ldyZuYnNwO3RpbWVvdXQmbmJzcDtlcnJvciZuYnNwO3JldHVybi48YnIgLz4mbmJzcDsm
bmJzcDstJm5ic3A7QWRkJm5ic3A7UENJZSZuYnNwO2xpbmsmbmJzcDtoZWFsdGgmbmJzcDtjaGVj
ay48YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7UmVtb3ZlJm5ic3A7dGhlJm5ic3A7TlAmbmJzcDtz
b2Z0d2FyZSZuYnNwO3Jlc291cmNlJm5ic3A7dW5pbnN0YWxsYXRpb24mbmJzcDtwcm9jZWR1cmUm
bmJzcDtmcm9tJm5ic3A7dGhlJm5ic3A7TlAmbmJzcDtvbmxpbmUmbmJzcDt1bmluaXQmbmJzcDtw
cm9jZXNzLiZuYnNwOw08YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7TlAmbmJzcDtzb2Z0d2FyZSZu
YnNwO3Jlc291cmNlJm5ic3A7dW5pbnN0YWxsYXRpb24mbmJzcDtzaG91bGQmbmJzcDtiZSZuYnNw
O2NhbGxlZCZuYnNwO3NlcGFyYXRlbHkmbmJzcDt3aXRoaW4mbmJzcDtOUCZuYnNwO3VuaW5pdCZu
YnNwO3RvJm5ic3A7YXZvaWQmbmJzcDtkdXBsaWNhdGUmbmJzcDtyZXNvdXJjZSZuYnNwO3JlbGVh
c2UuPGJyIC8+DTxiciAvPlRpYW5oYW8mbmJzcDtaaGFuZyZuYnNwOygyKTo8YnIgLz4mbmJzcDsm
bmJzcDtuZXQvenhkaDombmJzcDthZGQmbmJzcDtwY2llJm5ic3A7YmFyJm5ic3A7Y2hhbm5lbCZu
YnNwO2NoZWNrPGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7b3B0aW1pemUmbmJzcDt0
aGUmbmJzcDtwcm9jZWR1cmUmbmJzcDtmb3ImbmJzcDtOUCZuYnNwO29ubGluZSZuYnNwO3VuaW5p
dDxiciAvPg08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYyZuYnNwO3wmbmJz
cDsxMiZuYnNwOysrKysrKystLS0tLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9u
cC5oJm5ic3A7fCZuYnNwOyZuYnNwOzMmbmJzcDsrKys8YnIgLz4mbmJzcDsyJm5ic3A7ZmlsZXMm
bmJzcDtjaGFuZ2VkLCZuYnNwOzEwJm5ic3A7aW5zZXJ0aW9ucygrKSwmbmJzcDs1Jm5ic3A7ZGVs
ZXRpb25zKC0pPGJyIC8+DTxiciAvPi0tJm5ic3A7DTxiciAvPjIuMjcuMDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

