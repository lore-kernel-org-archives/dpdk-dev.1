Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C90C2A072
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 07:38:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 171944026F;
	Mon,  5 Jan 2026 08:38:18 +0100 (CET)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id E35D440267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 08:38:16 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4dl5kW5t1Cz51SW9;
 Mon, 05 Jan 2026 15:38:11 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 6057c4aZ082926;
 Mon, 5 Jan 2026 15:38:04 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 5 Jan 2026 15:38:06 +0800
X-Zmail-TransId: 3e81695b6a5a001-6495d
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>
Subject: [PATCH v2 0/5] net/zxdh: add support some new features
Date: Mon,  5 Jan 2026 15:16:38 +0800
Message-ID: <20260105071643.1119116-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251220061521.289722-1-wang.junlong1@zte.com.cn>
References: <20251220061521.289722-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 6057c4aZ082926
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 05 Jan 2026 15:38:11 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 695B6A63.000/4dl5kW5t1Cz51SW9
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

VjI6DQogIC0gYWRkIHVwZGF0ZWQgcmVsZWFzZSBub3RlIGFuZCB0aGUgZG9jdW1lbnRhdGlvbi4N
CiAgLSByZW1vdmUgdW5uZWNlc3NhcnkgaW5pdGlhbGl6YXRpb24uDQogIC0gdXNpbmcgdGhlIGNv
bXBpbGVyIGJ1aWx0aW5zKF9fcnRlX2NsejMyKS4NCiAgLSByZW1vdmUgQysrIHN0eWxlIGNvbW1l
bnRzLg0KDQpWMToNCiAgLSBzdXBwb3J0IG1vZGlmeWluZyBxdWV1ZSBkZXB0aC4NCiAgLSBvcHRp
bWV6ZSBhbGxvYyBxdWV1ZSByZXNvdXJjZXMuDQogIC0gc3VwcG9ydCBzZXQgbGluayBzcGVlZC4N
CiAgLSBzdXBwb3J0IHByaW1hcnkvc2Vjb25kYXJ5IHByb2Nlc3MuDQogIC0gc3VwcG9ydCBHRU5F
VkUgVFNPL2Noa3N1bSxhbmQgdHVubmVsIHBhY2tldHMgb3V0ZXIgdWRwIGNoa3N1bS4NCg0KSnVu
bG9uZyBXYW5nICg1KToNCiAgbmV0L3p4ZGg6IGFkZCBzdXBwb3J0IGZvciBtb2RpZnlpbmcgcXVl
dWUgZGVwdGgNCiAgbmV0L3p4ZGg6IG9wdGltaXplIGFsbG9jIHF1ZXVlIHJlc291cmNlcw0KICBu
ZXQvenhkaDogYWRkIHN1cHBvcnQgc2V0IGxpbmsgc3BlZWQgZ2V0IGF1dG9uZWcgc3RhdHMNCiAg
bmV0L3p4ZGg6IGFkZCBzdXBwb3J0IHByaW1hcnkvc2Vjb25kYXJ5IHByb2Nlc3MNCiAgbmV0L3p4
ZGg6IGFkZCBzdXBwb3J0IEdFTkVWRSBUU08gYW5kIFJ4IG91dGVyIGNoa3N1bQ0KDQogZG9jL2d1
aWRlcy9yZWxfbm90ZXMvcmVsZWFzZV8yNl8wMy5yc3QgfCAgIDcgKw0KIGRyaXZlcnMvbmV0L3p4
ZGgvenhkaF9jb21tb24uYyAgICAgICAgIHwgIDc1ICsrLS0tLS0tDQogZHJpdmVycy9uZXQvenhk
aC96eGRoX2NvbW1vbi5oICAgICAgICAgfCAgIDIgKy0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhf
ZXRoZGV2LmMgICAgICAgICB8IDIzOSArKysrKysrKysrKysrKysrKy0tLS0tLS0tDQogZHJpdmVy
cy9uZXQvenhkaC96eGRoX2V0aGRldi5oICAgICAgICAgfCAgMjMgKystDQogZHJpdmVycy9uZXQv
enhkaC96eGRoX2V0aGRldl9vcHMuYyAgICAgfCAxNjUgKysrKysrKysrKysrKy0tLS0NCiBkcml2
ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2X29wcy5oICAgICB8ICAxNSArKw0KIGRyaXZlcnMvbmV0
L3p4ZGgvenhkaF9tc2cuYyAgICAgICAgICAgIHwgIDUyICsrKysrKw0KIGRyaXZlcnMvbmV0L3p4
ZGgvenhkaF9tc2cuaCAgICAgICAgICAgIHwgIDI0ICsrLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhk
aF9wY2kuaCAgICAgICAgICAgIHwgICAyICsNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfcXVldWUu
YyAgICAgICAgICB8IDEzNCArKysrKysrKysrKy0tLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9x
dWV1ZS5oICAgICAgICAgIHwgIDEyICstDQogZHJpdmVycy9uZXQvenhkaC96eGRoX3J4dHguYyAg
ICAgICAgICAgfCAxMTYgKysrKysrKysrLS0tDQogZHJpdmVycy9uZXQvenhkaC96eGRoX3RhYmxl
cy5oICAgICAgICAgfCAgMTIgKy0NCiAxNCBmaWxlcyBjaGFuZ2VkLCA2NTEgaW5zZXJ0aW9ucygr
KSwgMjI3IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjI6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO2FkZCZuYnNwO3VwZGF0ZWQmbmJzcDtyZWxlYXNl
Jm5ic3A7bm90ZSZuYnNwO2FuZCZuYnNwO3RoZSZuYnNwO2RvY3VtZW50YXRpb24uPGJyIC8+Jm5i
c3A7Jm5ic3A7LSZuYnNwO3JlbW92ZSZuYnNwO3VubmVjZXNzYXJ5Jm5ic3A7aW5pdGlhbGl6YXRp
b24uPGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3VzaW5nJm5ic3A7dGhlJm5ic3A7Y29tcGlsZXIm
bmJzcDtidWlsdGlucyhfX3J0ZV9jbHozMikuPGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3JlbW92
ZSZuYnNwO0MrKyZuYnNwO3N0eWxlJm5ic3A7Y29tbWVudHMuPGJyIC8+DTxiciAvPlYxOjxiciAv
PiZuYnNwOyZuYnNwOy0mbmJzcDtzdXBwb3J0Jm5ic3A7bW9kaWZ5aW5nJm5ic3A7cXVldWUmbmJz
cDtkZXB0aC48YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7b3B0aW1lemUmbmJzcDthbGxvYyZuYnNw
O3F1ZXVlJm5ic3A7cmVzb3VyY2VzLjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtzdXBwb3J0Jm5i
c3A7c2V0Jm5ic3A7bGluayZuYnNwO3NwZWVkLjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtzdXBw
b3J0Jm5ic3A7cHJpbWFyeS9zZWNvbmRhcnkmbmJzcDtwcm9jZXNzLjxiciAvPiZuYnNwOyZuYnNw
Oy0mbmJzcDtzdXBwb3J0Jm5ic3A7R0VORVZFJm5ic3A7VFNPL2Noa3N1bSxhbmQmbmJzcDt0dW5u
ZWwmbmJzcDtwYWNrZXRzJm5ic3A7b3V0ZXImbmJzcDt1ZHAmbmJzcDtjaGtzdW0uPGJyIC8+DTxi
ciAvPkp1bmxvbmcmbmJzcDtXYW5nJm5ic3A7KDUpOjxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRo
OiZuYnNwO2FkZCZuYnNwO3N1cHBvcnQmbmJzcDtmb3ImbmJzcDttb2RpZnlpbmcmbmJzcDtxdWV1
ZSZuYnNwO2RlcHRoPGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7b3B0aW1pemUmbmJz
cDthbGxvYyZuYnNwO3F1ZXVlJm5ic3A7cmVzb3VyY2VzPGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4
ZGg6Jm5ic3A7YWRkJm5ic3A7c3VwcG9ydCZuYnNwO3NldCZuYnNwO2xpbmsmbmJzcDtzcGVlZCZu
YnNwO2dldCZuYnNwO2F1dG9uZWcmbmJzcDtzdGF0czxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRo
OiZuYnNwO2FkZCZuYnNwO3N1cHBvcnQmbmJzcDtwcmltYXJ5L3NlY29uZGFyeSZuYnNwO3Byb2Nl
c3M8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDthZGQmbmJzcDtzdXBwb3J0Jm5ic3A7
R0VORVZFJm5ic3A7VFNPJm5ic3A7YW5kJm5ic3A7UngmbmJzcDtvdXRlciZuYnNwO2Noa3N1bTxi
ciAvPg08YnIgLz4mbmJzcDtkb2MvZ3VpZGVzL3JlbF9ub3Rlcy9yZWxlYXNlXzI2XzAzLnJzdCZu
YnNwO3wmbmJzcDsmbmJzcDsmbmJzcDs3Jm5ic3A7KzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4
ZGgvenhkaF9jb21tb24uYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDs3NSZuYnNwOysrLS0tLS0tPGJyIC8+Jm5ic3A7ZHJp
dmVycy9uZXQvenhkaC96eGRoX2NvbW1vbi5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzImbmJzcDsrLTxiciAv
PiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXYuYyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsyMzkmbmJzcDsrKysrKysr
KysrKysrKysrKy0tLS0tLS0tPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRl
di5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
fCZuYnNwOyZuYnNwOzIzJm5ic3A7KystPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRo
X2V0aGRldl9vcHMuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsxNjUmbmJz
cDsrKysrKysrKysrKysrLS0tLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhk
ZXZfb3BzLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7MTUmbmJz
cDsrKzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cuYyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
O3wmbmJzcDsmbmJzcDs1MiZuYnNwOysrKysrKzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgv
enhkaF9tc2cuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsyNCZuYnNwOysrLTxiciAvPiZu
YnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9wY2kuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJz
cDsmbmJzcDsyJm5ic3A7KzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9xdWV1ZS5j
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7fCZuYnNwOzEzNCZuYnNwOysrKysrKysrKysrLS0tPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQv
enhkaC96eGRoX3F1ZXVlLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7MTImbmJzcDsrLTxiciAvPiZuYnNwO2Ry
aXZlcnMvbmV0L3p4ZGgvenhkaF9yeHR4LmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7MTE2Jm5ic3A7KysrKysr
KysrLS0tPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX3RhYmxlcy5oJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNw
OzEyJm5ic3A7Ky08YnIgLz4mbmJzcDsxNCZuYnNwO2ZpbGVzJm5ic3A7Y2hhbmdlZCwmbmJzcDs2
NTEmbmJzcDtpbnNlcnRpb25zKCspLCZuYnNwOzIyNyZuYnNwO2RlbGV0aW9ucygtKTxiciAvPg08
YnIgLz4tLSZuYnNwOw08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

