Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68676D79740
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 06:45:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2FD2402C1;
	Sat, 31 Jan 2026 07:45:42 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTP id 138CB402B2
 for <dev@dpdk.org>; Sat, 31 Jan 2026 07:45:40 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4f33Kt1dfgz6G3wp;
 Sat, 31 Jan 2026 14:45:38 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl1.zte.com.cn with SMTP id 60V6jUug021067;
 Sat, 31 Jan 2026 14:45:30 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Mon, 31 Jan 2026 14:45:32 +0800
X-Zmail-TransId: 3e81697da506000-e52cb
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>
Subject: [PATCH v3 0/5] net/zxdh: add support some new features
Date: Sat, 31 Jan 2026 14:22:03 +0800
Message-ID: <20260131062208.2445121-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105071643.1119116-1-wang.junlong1@zte.com.cn>
References: <20260105071643.1119116-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 60V6jUug021067
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sat, 31 Jan 2026 14:45:38 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 697DA512.000/4f33Kt1dfgz6G3wp
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

VjM6DQogIC0gbW9kaWZ5IHNvbWUgaXNzdWVzIGZyb20gQUkgcmV2aWV3Lg0KDQpWMjoNCiAgLSBh
ZGQgdXBkYXRlZCByZWxlYXNlIG5vdGUgYW5kIHRoZSBkb2N1bWVudGF0aW9uLg0KICAtIHJlbW92
ZSB1bm5lY2Vzc2FyeSBpbml0aWFsaXphdGlvbi4NCiAgLSB1c2luZyB0aGUgY29tcGlsZXIgYnVp
bHRpbnMoX19ydGVfY2x6MzIpLg0KICAtIHJlbW92ZSBDKysgc3R5bGUgY29tbWVudHMuDQoNClYx
Og0KICAtIHN1cHBvcnQgbW9kaWZ5aW5nIHF1ZXVlIGRlcHRoLg0KICAtIG9wdGltZXplIGFsbG9j
IHF1ZXVlIHJlc291cmNlcy4NCiAgLSBzdXBwb3J0IHNldCBsaW5rIHNwZWVkLg0KICAtIHN1cHBv
cnQgcHJpbWFyeS9zZWNvbmRhcnkgcHJvY2Vzcy4NCiAgLSBzdXBwb3J0IEdFTkVWRSBUU08vY2hr
c3VtLGFuZCB0dW5uZWwgcGFja2V0cyBvdXRlciB1ZHAgY2hrc3VtLg0KDQpKdW5sb25nIFdhbmcg
KDUpOg0KICBuZXQvenhkaDogYWRkIHN1cHBvcnQgZm9yIG1vZGlmeWluZyBxdWV1ZSBkZXB0aA0K
ICBuZXQvenhkaDogb3B0aW1pemUgYWxsb2MgcXVldWUgcmVzb3VyY2VzDQogIG5ldC96eGRoOiBh
ZGQgbGluayBzcGVlZCBzZXQgYW5kIGF1dG9uZWcgZ2V0IHN1cHBvcnQNCiAgbmV0L3p4ZGg6IGFk
ZCBzdXBwb3J0IGZvciBwcmltYXJ5L3NlY29uZGFyeSBwcm9jZXNzDQogIG5ldC96eGRoOiBhZGQg
c3VwcG9ydCBmb3IgR0VORVZFIFRTTyBhbmQgUnggb3V0ZXIgY2hlY2tzdW0NCg0KIGRvYy9ndWlk
ZXMvcmVsX25vdGVzL3JlbGVhc2VfMjZfMDMucnN0IHwgICA3ICsNCiBkcml2ZXJzL25ldC96eGRo
L3p4ZGhfY29tbW9uLmMgICAgICAgICB8ICA3NSArKy0tLS0tLQ0KIGRyaXZlcnMvbmV0L3p4ZGgv
enhkaF9jb21tb24uaCAgICAgICAgIHwgICAyICstDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2V0
aGRldi5jICAgICAgICAgfCAyMzkgKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIGRyaXZlcnMv
bmV0L3p4ZGgvenhkaF9ldGhkZXYuaCAgICAgICAgIHwgIDIzICsrLQ0KIGRyaXZlcnMvbmV0L3p4
ZGgvenhkaF9ldGhkZXZfb3BzLmMgICAgIHwgMTY1ICsrKysrKysrKysrKysrLS0tDQogZHJpdmVy
cy9uZXQvenhkaC96eGRoX2V0aGRldl9vcHMuaCAgICAgfCAgMTUgKysNCiBkcml2ZXJzL25ldC96
eGRoL3p4ZGhfbXNnLmMgICAgICAgICAgICB8ICA1MiArKysrKysNCiBkcml2ZXJzL25ldC96eGRo
L3p4ZGhfbXNnLmggICAgICAgICAgICB8ICAyNCArKy0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhf
cGNpLmggICAgICAgICAgICB8ICAgMiArDQogZHJpdmVycy9uZXQvenhkaC96eGRoX3F1ZXVlLmMg
ICAgICAgICAgfCAxMzcgKysrKysrKysrKystLS0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfcXVl
dWUuaCAgICAgICAgICB8ICAxMiArLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9yeHR4LmMgICAg
ICAgICAgIHwgMTE3ICsrKysrKysrKy0tLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF90YWJsZXMu
aCAgICAgICAgIHwgIDEyICstDQogMTQgZmlsZXMgY2hhbmdlZCwgNjU1IGluc2VydGlvbnMoKyks
IDIyNyBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI3LjA=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjM6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO21vZGlmeSZuYnNwO3NvbWUmbmJzcDtpc3N1ZXMm
bmJzcDtmcm9tJm5ic3A7QUkmbmJzcDtyZXZpZXcuPGJyIC8+DTxiciAvPlYyOjxiciAvPiZuYnNw
OyZuYnNwOy0mbmJzcDthZGQmbmJzcDt1cGRhdGVkJm5ic3A7cmVsZWFzZSZuYnNwO25vdGUmbmJz
cDthbmQmbmJzcDt0aGUmbmJzcDtkb2N1bWVudGF0aW9uLjxiciAvPiZuYnNwOyZuYnNwOy0mbmJz
cDtyZW1vdmUmbmJzcDt1bm5lY2Vzc2FyeSZuYnNwO2luaXRpYWxpemF0aW9uLjxiciAvPiZuYnNw
OyZuYnNwOy0mbmJzcDt1c2luZyZuYnNwO3RoZSZuYnNwO2NvbXBpbGVyJm5ic3A7YnVpbHRpbnMo
X19ydGVfY2x6MzIpLjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtyZW1vdmUmbmJzcDtDKysmbmJz
cDtzdHlsZSZuYnNwO2NvbW1lbnRzLjxiciAvPg08YnIgLz5WMTo8YnIgLz4mbmJzcDsmbmJzcDst
Jm5ic3A7c3VwcG9ydCZuYnNwO21vZGlmeWluZyZuYnNwO3F1ZXVlJm5ic3A7ZGVwdGguPGJyIC8+
Jm5ic3A7Jm5ic3A7LSZuYnNwO29wdGltZXplJm5ic3A7YWxsb2MmbmJzcDtxdWV1ZSZuYnNwO3Jl
c291cmNlcy48YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7c3VwcG9ydCZuYnNwO3NldCZuYnNwO2xp
bmsmbmJzcDtzcGVlZC48YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7c3VwcG9ydCZuYnNwO3ByaW1h
cnkvc2Vjb25kYXJ5Jm5ic3A7cHJvY2Vzcy48YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7c3VwcG9y
dCZuYnNwO0dFTkVWRSZuYnNwO1RTTy9jaGtzdW0sYW5kJm5ic3A7dHVubmVsJm5ic3A7cGFja2V0
cyZuYnNwO291dGVyJm5ic3A7dWRwJm5ic3A7Y2hrc3VtLjxiciAvPg08YnIgLz5KdW5sb25nJm5i
c3A7V2FuZyZuYnNwOyg1KTo8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDthZGQmbmJz
cDtzdXBwb3J0Jm5ic3A7Zm9yJm5ic3A7bW9kaWZ5aW5nJm5ic3A7cXVldWUmbmJzcDtkZXB0aDxi
ciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO29wdGltaXplJm5ic3A7YWxsb2MmbmJzcDtx
dWV1ZSZuYnNwO3Jlc291cmNlczxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO2FkZCZu
YnNwO2xpbmsmbmJzcDtzcGVlZCZuYnNwO3NldCZuYnNwO2FuZCZuYnNwO2F1dG9uZWcmbmJzcDtn
ZXQmbmJzcDtzdXBwb3J0PGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7YWRkJm5ic3A7
c3VwcG9ydCZuYnNwO2ZvciZuYnNwO3ByaW1hcnkvc2Vjb25kYXJ5Jm5ic3A7cHJvY2VzczxiciAv
PiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO2FkZCZuYnNwO3N1cHBvcnQmbmJzcDtmb3ImbmJz
cDtHRU5FVkUmbmJzcDtUU08mbmJzcDthbmQmbmJzcDtSeCZuYnNwO291dGVyJm5ic3A7Y2hlY2tz
dW08YnIgLz4NPGJyIC8+Jm5ic3A7ZG9jL2d1aWRlcy9yZWxfbm90ZXMvcmVsZWFzZV8yNl8wMy5y
c3QmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7NyZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25l
dC96eGRoL3p4ZGhfY29tbW9uLmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7NzUmbmJzcDsrKy0tLS0tLTxiciAvPiZuYnNw
O2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9jb21tb24uaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsyJm5ic3A7Ky08
YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2LmMmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7MjM5Jm5ic3A7Kysr
KysrKysrKysrKysrKystLS0tLS0tLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9l
dGhkZXYuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwO3wmbmJzcDsmbmJzcDsyMyZuYnNwOysrLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgv
enhkaF9ldGhkZXZfb3BzLmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7MTY1
Jm5ic3A7KysrKysrKysrKysrKystLS08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhf
ZXRoZGV2X29wcy5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOzE1
Jm5ic3A7Kys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDt8Jm5ic3A7Jm5ic3A7NTImbmJzcDsrKysrKys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96
eGRoL3p4ZGhfbXNnLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7MjQmbmJzcDsrKy08YnIg
Lz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfcGNpLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7
Jm5ic3A7Jm5ic3A7MiZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfcXVl
dWUuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwO3wmbmJzcDsxMzcmbmJzcDsrKysrKysrKysrKy0tLTxiciAvPiZuYnNwO2RyaXZlcnMv
bmV0L3p4ZGgvenhkaF9xdWV1ZS5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOzEyJm5ic3A7Ky08YnIgLz4mbmJz
cDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfcnh0eC5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOzExNyZuYnNwOysr
KysrKysrKy0tLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF90YWJsZXMuaCZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsm
bmJzcDsxMiZuYnNwOystPGJyIC8+Jm5ic3A7MTQmbmJzcDtmaWxlcyZuYnNwO2NoYW5nZWQsJm5i
c3A7NjU1Jm5ic3A7aW5zZXJ0aW9ucygrKSwmbmJzcDsyMjcmbmJzcDtkZWxldGlvbnMoLSk8YnIg
Lz4NPGJyIC8+LS0mbmJzcDsNPGJyIC8+Mi4yNy4wPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

