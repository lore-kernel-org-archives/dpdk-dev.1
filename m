Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4E8C83F1D
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 11:04:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE154402D4;
	Thu, 10 Jul 2025 13:04:31 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTP id 03ACD402D1
 for <dev@dpdk.org>; Thu, 10 Jul 2025 13:04:29 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bdBn70Vykz5F2lp;
 Thu, 10 Jul 2025 19:04:27 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
 by mse-fl2.zte.com.cn with SMTP id 56AB4A5p061579;
 Thu, 10 Jul 2025 19:04:10 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 10 Jul 2025 19:04:12 +0800
X-Zmail-TransId: 3e81686f9e27001-1b82e
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>
Subject: [PATCH v2 0/6] net/zxdh: fix meson.build issues in compilation
Date: Thu, 10 Jul 2025 18:56:37 +0800
Message-ID: <20250710105643.516329-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707055621.357606-1-wang.junlong1@zte.com.cn>
References: <20250707055621.357606-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 56AB4A5p061579
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 686F9E3B.000/4bdBn70Vykz5F2lp
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

djI6DQogIC0gdXNpbmcgc3RydWN0dXJlIGFzc2lnbm1lbnQgb3BlcmF0aW9uIGluc3RlYWQgb2Yg
bWVtY3B5Lg0KICAgIG1hY19maWx0ZXItPm1hYyA9IGV0aF9kZXYtPmRhdGEtPm1hY19hZGRyczsN
Cg0KSnVubG9uZyBXYW5nICg2KToNCiAgbmV0L3p4ZGg6IGZpeCBtZXNvbi5idWlsZCBpc3N1ZXMg
aW4gY29tcGlsYXRpb24NCiAgbmV0L3p4ZGg6IGZpeCBpc3N1ZXMgcmVsYXRlZCB0byBNQUMgY29u
ZmlndXJhdGlvbg0KICBuZXQvenhkaDogZml4IHNvbWUgVkxBTiByZWxhdGVkIGlzc3Vlcw0KICBu
ZXQvenhkaDogZml4IFJTUyByZWxhdGVkIGlzc3Vlcw0KICBuZXQvenhkaDogYWRkIHN1cHBvcnQg
VkxBTiBUUElEIHNldCBvcHMNCiAgbmV0L3p4ZGg6IGFkZCBzdXBwb3J0IEk1MTAvNTExIFBGIGRl
dmljZSBJRA0KDQogZHJpdmVycy9uZXQvenhkaC9tZXNvbi5idWlsZCAgICAgICB8ICAgMiArLQ0K
IGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9jb21tb24uYyAgICAgfCAgIDIgKy0NCiBkcml2ZXJzL25l
dC96eGRoL3p4ZGhfZXRoZGV2LmMgICAgIHwgMTA5ICsrKysrKysrKysrKysrKysrKysrLS0NCiBk
cml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2LmggICAgIHwgICA3ICstDQogZHJpdmVycy9uZXQv
enhkaC96eGRoX2V0aGRldl9vcHMuYyB8IDE0NCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXZfb3BzLmggfCAgIDEgKw0KIGRyaXZlcnMv
bmV0L3p4ZGgvenhkaF9tc2cuYyAgICAgICAgfCAxMjMgKysrKysrKysrKysrKysrKysrKysrLS0t
DQogZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5oICAgICAgICB8ICAzMCArKysrKysNCiBkcml2
ZXJzL25ldC96eGRoL3p4ZGhfcGNpLmMgICAgICAgIHwgICAyICsNCiBkcml2ZXJzL25ldC96eGRo
L3p4ZGhfdGFibGVzLmMgICAgIHwgIDcwICsrKysrKysrLS0tLS0tDQogZHJpdmVycy9uZXQvenhk
aC96eGRoX3RhYmxlcy5oICAgICB8ICAgNyArLQ0KIDExIGZpbGVzIGNoYW5nZWQsIDQxNiBpbnNl
cnRpb25zKCspLCA4MSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI3LjA=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

djI6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3VzaW5nJm5ic3A7c3RydWN0dXJlJm5ic3A7YXNz
aWdubWVudCZuYnNwO29wZXJhdGlvbiZuYnNwO2luc3RlYWQmbmJzcDtvZiZuYnNwO21lbWNweS48
YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDttYWNfZmlsdGVyLSZndDttYWMmbmJzcDs9Jm5i
c3A7ZXRoX2Rldi0mZ3Q7ZGF0YS0mZ3Q7bWFjX2FkZHJzOzxiciAvPg08YnIgLz5KdW5sb25nJm5i
c3A7V2FuZyZuYnNwOyg2KTo8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDtmaXgmbmJz
cDttZXNvbi5idWlsZCZuYnNwO2lzc3VlcyZuYnNwO2luJm5ic3A7Y29tcGlsYXRpb248YnIgLz4m
bmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDtmaXgmbmJzcDtpc3N1ZXMmbmJzcDtyZWxhdGVkJm5i
c3A7dG8mbmJzcDtNQUMmbmJzcDtjb25maWd1cmF0aW9uPGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4
ZGg6Jm5ic3A7Zml4Jm5ic3A7c29tZSZuYnNwO1ZMQU4mbmJzcDtyZWxhdGVkJm5ic3A7aXNzdWVz
PGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7Zml4Jm5ic3A7UlNTJm5ic3A7cmVsYXRl
ZCZuYnNwO2lzc3VlczxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO2FkZCZuYnNwO3N1
cHBvcnQmbmJzcDtWTEFOJm5ic3A7VFBJRCZuYnNwO3NldCZuYnNwO29wczxiciAvPiZuYnNwOyZu
YnNwO25ldC96eGRoOiZuYnNwO2FkZCZuYnNwO3N1cHBvcnQmbmJzcDtJNTEwLzUxMSZuYnNwO1BG
Jm5ic3A7ZGV2aWNlJm5ic3A7SUQ8YnIgLz4NPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC9t
ZXNvbi5idWlsZCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJz
cDsmbmJzcDsmbmJzcDsyJm5ic3A7Ky08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhf
Y29tbW9uLmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7
MiZuYnNwOystPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldi5jJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOzEwOSZuYnNwOysrKysrKysrKysrKysrKysr
KysrLS08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2LmgmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7NyZuYnNwOystPGJyIC8+Jm5i
c3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldl9vcHMuYyZuYnNwO3wmbmJzcDsxNDQmbmJz
cDsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4
ZGgvenhkaF9ldGhkZXZfb3BzLmgmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MSZuYnNwOys8YnIg
Lz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7MTIzJm5ic3A7KysrKysrKysrKysrKysr
KysrKysrLS0tPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5oJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOzMwJm5i
c3A7KysrKysrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX3BjaS5jJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNw
OzImbmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX3RhYmxlcy5jJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOzcwJm5ic3A7KysrKysrKystLS0t
LS08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmgmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7NyZuYnNwOystPGJyIC8+Jm5ic3A7
MTEmbmJzcDtmaWxlcyZuYnNwO2NoYW5nZWQsJm5ic3A7NDE2Jm5ic3A7aW5zZXJ0aW9ucygrKSwm
bmJzcDs4MSZuYnNwO2RlbGV0aW9ucygtKTxiciAvPg08YnIgLz4tLSZuYnNwOw08YnIgLz4yLjI3
LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

