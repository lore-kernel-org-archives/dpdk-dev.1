Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9FAE6689E
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Dec 2025 06:35:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79FF940296;
	Sat, 20 Dec 2025 07:35:40 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 1002F4026A
 for <dev@dpdk.org>; Sat, 20 Dec 2025 07:35:38 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dYF5g14pJz8Xs71;
 Sat, 20 Dec 2025 14:35:35 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
 by mse-fl1.zte.com.cn with SMTP id 5BK6ZRLa061627;
 Sat, 20 Dec 2025 14:35:27 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Sat, 20 Dec 2025 14:35:29 +0800
X-Zmail-TransId: 3e81694643ac00f-d37fe
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>
Subject: [PATCH v1 0/5] net/zxdh: add support some new features
Date: Sat, 20 Dec 2025 14:15:16 +0800
Message-ID: <20251220061521.289722-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 5BK6ZRLa061627
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sat, 20 Dec 2025 14:35:35 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 694643B7.000/4dYF5g14pJz8Xs71
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

VjE6DQogIC0gc3VwcG9ydCBtb2RpZnlpbmcgcXVldWUgZGVwdGguDQogIC0gb3B0aW1lemUgYWxs
b2MgcXVldWUgcmVzb3VyY2VzLg0KICAtIHN1cHBvcnQgc2V0IGxpbmsgc3BlZWQuDQogIC0gc3Vw
cG9ydCBwcmltYXJ5L3NlY29uZGFyeSBwcm9jZXNzLg0KICAtIHN1cHBvcnQgR0VORVZFIFRTTy9j
aGtzdW0sYW5kIHR1bm5lbCBwYWNrZXRzIG91dGVyIHVkcCBjaGtzdW0uDQoNCkp1bmxvbmcgV2Fu
ZyAoNSk6DQogIG5ldC96eGRoOiBhZGQgc3VwcG9ydCBmb3IgbW9kaWZ5aW5nIHF1ZXVlIGRlcHRo
DQogIG5ldC96eGRoOiBvcHRpbWl6ZSBhbGxvYyBxdWV1ZSByZXNvdXJjZXMNCiAgbmV0L3p4ZGg6
IGFkZCBzdXBwb3J0IHNldCBsaW5rIHNwZWVkIGdldCBhdXRvbmVnIHN0YXRzDQogIG5ldC96eGRo
OiBhZGQgc3VwcG9ydCBwcmltYXJ5L3NlY29uZGFyeSBwcm9jZXNzDQogIG5ldC96eGRoOiBhZGQg
c3VwcG9ydCBHRU5FVkUgVFNPIGFuZCBSeCBvdXRlciBVRFAgY2hrc3VtDQoNCiBkcml2ZXJzL25l
dC96eGRoL3p4ZGhfY29tbW9uLmMgICAgIHwgIDc1ICsrLS0tLS0tLQ0KIGRyaXZlcnMvbmV0L3p4
ZGgvenhkaF9jb21tb24uaCAgICAgfCAgIDIgKy0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRo
ZGV2LmMgICAgIHwgMjM5ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQogZHJpdmVycy9u
ZXQvenhkaC96eGRoX2V0aGRldi5oICAgICB8ICAyMyArKy0NCiBkcml2ZXJzL25ldC96eGRoL3p4
ZGhfZXRoZGV2X29wcy5jIHwgMTY1ICsrKysrKysrKysrKysrKystLS0tDQogZHJpdmVycy9uZXQv
enhkaC96eGRoX2V0aGRldl9vcHMuaCB8ICAxNSArKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9t
c2cuYyAgICAgICAgfCAgNTIgKysrKysrKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cuaCAg
ICAgICAgfCAgMjQgKystDQogZHJpdmVycy9uZXQvenhkaC96eGRoX3BjaS5oICAgICAgICB8ICAg
MiArDQogZHJpdmVycy9uZXQvenhkaC96eGRoX3F1ZXVlLmMgICAgICB8IDEzNyArKysrKysrKysr
KysrKy0tLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9xdWV1ZS5oICAgICAgfCAgMTIgKy0NCiBk
cml2ZXJzL25ldC96eGRoL3p4ZGhfcnh0eC5jICAgICAgIHwgMTE3ICsrKysrKysrKystLS0tDQog
ZHJpdmVycy9uZXQvenhkaC96eGRoX3RhYmxlcy5oICAgICB8ICAxMiArLQ0KIDEzIGZpbGVzIGNo
YW5nZWQsIDY0OSBpbnNlcnRpb25zKCspLCAyMjYgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yNy4w

--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjE6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3N1cHBvcnQmbmJzcDttb2RpZnlpbmcmbmJzcDtx
dWV1ZSZuYnNwO2RlcHRoLjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtvcHRpbWV6ZSZuYnNwO2Fs
bG9jJm5ic3A7cXVldWUmbmJzcDtyZXNvdXJjZXMuPGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3N1
cHBvcnQmbmJzcDtzZXQmbmJzcDtsaW5rJm5ic3A7c3BlZWQuPGJyIC8+Jm5ic3A7Jm5ic3A7LSZu
YnNwO3N1cHBvcnQmbmJzcDtwcmltYXJ5L3NlY29uZGFyeSZuYnNwO3Byb2Nlc3MuPGJyIC8+Jm5i
c3A7Jm5ic3A7LSZuYnNwO3N1cHBvcnQmbmJzcDtHRU5FVkUmbmJzcDtUU08vY2hrc3VtLGFuZCZu
YnNwO3R1bm5lbCZuYnNwO3BhY2tldHMmbmJzcDtvdXRlciZuYnNwO3VkcCZuYnNwO2Noa3N1bS48
YnIgLz4NPGJyIC8+SnVubG9uZyZuYnNwO1dhbmcmbmJzcDsoNSk6PGJyIC8+Jm5ic3A7Jm5ic3A7
bmV0L3p4ZGg6Jm5ic3A7YWRkJm5ic3A7c3VwcG9ydCZuYnNwO2ZvciZuYnNwO21vZGlmeWluZyZu
YnNwO3F1ZXVlJm5ic3A7ZGVwdGg8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDtvcHRp
bWl6ZSZuYnNwO2FsbG9jJm5ic3A7cXVldWUmbmJzcDtyZXNvdXJjZXM8YnIgLz4mbmJzcDsmbmJz
cDtuZXQvenhkaDombmJzcDthZGQmbmJzcDtzdXBwb3J0Jm5ic3A7c2V0Jm5ic3A7bGluayZuYnNw
O3NwZWVkJm5ic3A7Z2V0Jm5ic3A7YXV0b25lZyZuYnNwO3N0YXRzPGJyIC8+Jm5ic3A7Jm5ic3A7
bmV0L3p4ZGg6Jm5ic3A7YWRkJm5ic3A7c3VwcG9ydCZuYnNwO3ByaW1hcnkvc2Vjb25kYXJ5Jm5i
c3A7cHJvY2VzczxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO2FkZCZuYnNwO3N1cHBv
cnQmbmJzcDtHRU5FVkUmbmJzcDtUU08mbmJzcDthbmQmbmJzcDtSeCZuYnNwO291dGVyJm5ic3A7
VURQJm5ic3A7Y2hrc3VtPGJyIC8+DTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9j
b21tb24uYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDs3NSZuYnNw
OysrLS0tLS0tLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9jb21tb24uaCZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsyJm5ic3A7Ky08YnIg
Lz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2LmMmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDt8Jm5ic3A7MjM5Jm5ic3A7KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS08
YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2LmgmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7MjMmbmJzcDsrKy08YnIgLz4mbmJzcDtkcml2ZXJz
L25ldC96eGRoL3p4ZGhfZXRoZGV2X29wcy5jJm5ic3A7fCZuYnNwOzE2NSZuYnNwOysrKysrKysr
KysrKysrKystLS0tPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldl9vcHMu
aCZuYnNwO3wmbmJzcDsmbmJzcDsxNSZuYnNwOysrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhk
aC96eGRoX21zZy5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7fCZuYnNwOyZuYnNwOzUyJm5ic3A7KysrKysrKzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4
ZGgvenhkaF9tc2cuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwO3wmbmJzcDsmbmJzcDsyNCZuYnNwOysrLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgv
enhkaF9wY2kuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
O3wmbmJzcDsmbmJzcDsmbmJzcDsyJm5ic3A7KzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgv
enhkaF9xdWV1ZS5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOzEz
NyZuYnNwOysrKysrKysrKysrKysrLS0tPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRo
X3F1ZXVlLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7
MTImbmJzcDsrLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9yeHR4LmMmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7MTE3Jm5ic3A7KysrKysr
KysrKy0tLS08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmgmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7MTImbmJzcDsrLTxiciAvPiZuYnNw
OzEzJm5ic3A7ZmlsZXMmbmJzcDtjaGFuZ2VkLCZuYnNwOzY0OSZuYnNwO2luc2VydGlvbnMoKyks
Jm5ic3A7MjI2Jm5ic3A7ZGVsZXRpb25zKC0pPGJyIC8+DTxiciAvPi0tJm5ic3A7DTxiciAvPjIu
MjcuMDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

