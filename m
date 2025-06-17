Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606CCC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 09:37:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F7BA40B8C;
	Tue, 17 Jun 2025 11:37:31 +0200 (CEST)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id BEDD340A89
 for <dev@dpdk.org>; Tue, 17 Jun 2025 11:37:28 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4bM1xH1CyMz4x5rh;
 Tue, 17 Jun 2025 17:37:23 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl2.zte.com.cn with SMTP id 55H9b1Fk042003;
 Tue, 17 Jun 2025 17:37:01 +0800 (+08)
 (envelope-from chen.bingbin@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Tue, 17 Jun 2025 17:37:04 +0800
X-Zmail-TransId: 3e8168513737008-5fbad
From: Bingbin Chen <chen.bingbin@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Bingbin Chen <chen.bingbin@zte.com.cn>
Subject: [PATCH v1 0/2] add support flow director ops
Date: Tue, 17 Jun 2025 17:31:14 +0800
Message-ID: <20250617093114.3570444-1-chen.bingbin@zte.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 55H9b1Fk042003
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68513753.000/4bM1xH1CyMz4x5rh
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

VjE6DQogIC0gYWRkIHN1cHBvcnQgZmxvdyBkaXJlY3RvciBvcHMuDQoNCkJpbmdiaW4gQ2hlbiAo
Mik6DQogIG5ldC96eGRoOiBucHNkayBhZGQgZmxvdyBkaXJlY3RvciB0YWJsZSBvcHMNCiAgbmV0
L3p4ZGg6IGFkZCBzdXBwb3J0IGZsb3cgZGlyZWN0b3Igb3BzDQoNCiBkb2MvZ3VpZGVzL25pY3Mv
ZmVhdHVyZXMvenhkaC5pbmkgIHwgICAxNiArDQogZG9jL2d1aWRlcy9uaWNzL3p4ZGgucnN0ICAg
ICAgICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQgICAgICAgfCAg
ICAxICsNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfY29tbW9uLmggICAgIHwgICAgMSArDQogZHJp
dmVycy9uZXQvenhkaC96eGRoX2V0aGRldi5jICAgICB8ICAgMjcgKw0KIGRyaXZlcnMvbmV0L3p4
ZGgvenhkaF9ldGhkZXYuaCAgICAgfCAgIDEzICstDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2V0
aGRldl9vcHMuYyB8ICAgIDIgKy0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2X29wcy5o
IHwgICAgMSArDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2Zsb3cuYyAgICAgICB8IDIwMDQgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93Lmgg
ICAgICAgfCAgMjM3ICsrKysNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMgICAgICAgIHwg
IDI2MyArKystDQogZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5oICAgICAgICB8ICAgMzEgKy0N
CiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYyAgICAgICAgIHwgMTY2NCArKysrKysrKysrKysr
KysrKysrKysrKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5oICAgICAgICAgfCAgIDQyICst
DQogZHJpdmVycy9uZXQvenhkaC96eGRoX3RhYmxlcy5oICAgICB8ICAgMTAgKy0NCiAxNSBmaWxl
cyBjaGFuZ2VkLCA0MjQxIGluc2VydGlvbnMoKyksIDcyIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5jDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmgNCg0KLS0gDQoyLjI3LjA=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjE6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO2FkZCZuYnNwO3N1cHBvcnQmbmJzcDtmbG93Jm5i
c3A7ZGlyZWN0b3ImbmJzcDtvcHMuPGJyIC8+DTxiciAvPkJpbmdiaW4mbmJzcDtDaGVuJm5ic3A7
KDIpOjxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO25wc2RrJm5ic3A7YWRkJm5ic3A7
ZmxvdyZuYnNwO2RpcmVjdG9yJm5ic3A7dGFibGUmbmJzcDtvcHM8YnIgLz4mbmJzcDsmbmJzcDtu
ZXQvenhkaDombmJzcDthZGQmbmJzcDtzdXBwb3J0Jm5ic3A7ZmxvdyZuYnNwO2RpcmVjdG9yJm5i
c3A7b3BzPGJyIC8+DTxiciAvPiZuYnNwO2RvYy9ndWlkZXMvbmljcy9mZWF0dXJlcy96eGRoLmlu
aSZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsxNiZuYnNwOys8YnIgLz4mbmJzcDtkb2Mv
Z3VpZGVzL25pY3MvenhkaC5yc3QmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7MSZu
YnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL21lc29uLmJ1aWxkJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzEm
bmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2NvbW1vbi5oJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzEmbmJzcDsrPGJy
IC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldi5jJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzI3Jm5ic3A7KzxiciAvPiZuYnNwO2RyaXZl
cnMvbmV0L3p4ZGgvenhkaF9ldGhkZXYuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wm
bmJzcDsmbmJzcDsmbmJzcDsxMyZuYnNwOystPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96
eGRoX2V0aGRldl9vcHMuYyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsyJm5ic3A7Ky08
YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2X29wcy5oJm5ic3A7fCZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOzEmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96
eGRoX2Zsb3cuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJz
cDsyMDA0Jm5ic3A7KysrKysrKysrKysrKysrKysrKysrKysrKysrKzxiciAvPiZuYnNwO2RyaXZl
cnMvbmV0L3p4ZGgvenhkaF9mbG93LmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDt8Jm5ic3A7Jm5ic3A7MjM3Jm5ic3A7KysrKzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0
L3p4ZGgvenhkaF9tc2cuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwO3wmbmJzcDsmbmJzcDsyNjMmbmJzcDsrKystPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQv
enhkaC96eGRoX21zZy5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzMxJm5ic3A7Ky08YnIgLz4mbmJzcDtkcml2ZXJzL25l
dC96eGRoL3p4ZGhfbnAuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwO3wmbmJzcDsxNjY0Jm5ic3A7KysrKysrKysrKysrKysrKysrKysrKys8YnIg
Lz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDs0MiZuYnNw
OystPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX3RhYmxlcy5oJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzEwJm5ic3A7Ky08YnIgLz4mbmJz
cDsxNSZuYnNwO2ZpbGVzJm5ic3A7Y2hhbmdlZCwmbmJzcDs0MjQxJm5ic3A7aW5zZXJ0aW9ucygr
KSwmbmJzcDs3MiZuYnNwO2RlbGV0aW9ucygtKTxiciAvPiZuYnNwO2NyZWF0ZSZuYnNwO21vZGUm
bmJzcDsxMDA2NDQmbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5jPGJyIC8+Jm5ic3A7
Y3JlYXRlJm5ic3A7bW9kZSZuYnNwOzEwMDY0NCZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9m
bG93Lmg8YnIgLz4NPGJyIC8+LS0mbmJzcDsNPGJyIC8+Mi4yNy4wPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

