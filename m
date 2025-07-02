Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40779C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 07:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56A6040285;
	Wed,  2 Jul 2025 09:42:09 +0200 (CEST)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id 8C26040269
 for <dev@dpdk.org>; Wed,  2 Jul 2025 09:42:06 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4bXBgD2TtPz4xfxH;
 Wed,  2 Jul 2025 15:42:00 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl1.zte.com.cn with SMTP id 5627fiJg040744;
 Wed, 2 Jul 2025 15:41:44 +0800 (+08)
 (envelope-from chen.bingbin@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 2 Jul 2025 15:41:47 +0800
X-Zmail-TransId: 3e816864e2b5000-5f9b2
X-Zmail-RealSender: chen.bingbin@zte.com.cn
From: Bingbin Chen <chen.bingbin@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Bingbin Chen <chen.bingbin@zte.com.cn>
Subject: [PATCH v3 0/2] add support flow director ops
Date: Wed,  2 Jul 2025 15:34:43 +0800
Message-ID: <20250702073453.113779-1-chen.bingbin@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618074936.3616999-1-chen.bingbin@zte.com.cn>
References: <20250618074936.3616999-1-chen.bingbin@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 5627fiJg040744
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6864E2C8.001/4bXBgD2TtPz4xfxH
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

VjM6DQogIC0gZml4IHNldmVyYWwgY2hlY2twYXRjaCB3YXJuaW5ncy4NCg0KVjI6DQogIC0gcmVz
b2x2ZSBjb2RlIHN0eWxlIGFuZCBnY2MgY29tcGlsYXRpb24gaXNzdWUuDQoNClYxOg0KICAtIGFk
ZCBzdXBwb3J0IGZsb3cgZGlyZWN0b3Igb3BzLg0KDQpCaW5nYmluIENoZW4gKDIpOg0KICBuZXQv
enhkaDogbnBzZGsgYWRkIGZsb3cgZGlyZWN0b3IgdGFibGUgb3BzDQogIG5ldC96eGRoOiBhZGQg
c3VwcG9ydCBmbG93IGRpcmVjdG9yIG9wcw0KDQogZG9jL2d1aWRlcy9uaWNzL2ZlYXR1cmVzL3p4
ZGguaW5pICB8ICAgMTYgKw0KIGRvYy9ndWlkZXMvbmljcy96eGRoLnJzdCAgICAgICAgICAgfCAg
ICAxICsNCiBkcml2ZXJzL25ldC96eGRoL21lc29uLmJ1aWxkICAgICAgIHwgICAgMSArDQogZHJp
dmVycy9uZXQvenhkaC96eGRoX2NvbW1vbi5oICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvbmV0L3p4
ZGgvenhkaF9ldGhkZXYuYyAgICAgfCAgIDI3ICsNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRo
ZGV2LmggICAgIHwgICAxMyArLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXZfb3BzLmMg
fCAgIDEwICstDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldl9vcHMuaCB8ICAgIDEgKw0K
IGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmMgICAgICAgfCAyMDAzICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5oICAgICAgIHwgIDIz
NyArKysrDQogZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5jICAgICAgICB8ICAyNjMgKysrLQ0K
IGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cuaCAgICAgICAgfCAgIDMxICstDQogZHJpdmVycy9u
ZXQvenhkaC96eGRoX25wLmMgICAgICAgICB8IDE2MzggKysrKysrKysrKysrKysrKysrKysrKysN
CiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuaCAgICAgICAgIHwgICAzMSArLQ0KIGRyaXZlcnMv
bmV0L3p4ZGgvenhkaF90YWJsZXMuaCAgICAgfCAgIDEwICstDQogMTUgZmlsZXMgY2hhbmdlZCwg
NDIwNyBpbnNlcnRpb25zKCspLCA3NiBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9uZXQvenhkaC96eGRoX2Zsb3cuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L25ldC96eGRoL3p4ZGhfZmxvdy5oDQoNCi0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjM6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO2ZpeCZuYnNwO3NldmVyYWwmbmJzcDtjaGVja3Bh
dGNoJm5ic3A7d2FybmluZ3MuPGJyIC8+DTxiciAvPlYyOjxiciAvPiZuYnNwOyZuYnNwOy0mbmJz
cDtyZXNvbHZlJm5ic3A7Y29kZSZuYnNwO3N0eWxlJm5ic3A7YW5kJm5ic3A7Z2NjJm5ic3A7Y29t
cGlsYXRpb24mbmJzcDtpc3N1ZS48YnIgLz4NPGJyIC8+VjE6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZu
YnNwO2FkZCZuYnNwO3N1cHBvcnQmbmJzcDtmbG93Jm5ic3A7ZGlyZWN0b3ImbmJzcDtvcHMuPGJy
IC8+DTxiciAvPkJpbmdiaW4mbmJzcDtDaGVuJm5ic3A7KDIpOjxiciAvPiZuYnNwOyZuYnNwO25l
dC96eGRoOiZuYnNwO25wc2RrJm5ic3A7YWRkJm5ic3A7ZmxvdyZuYnNwO2RpcmVjdG9yJm5ic3A7
dGFibGUmbmJzcDtvcHM8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDthZGQmbmJzcDtz
dXBwb3J0Jm5ic3A7ZmxvdyZuYnNwO2RpcmVjdG9yJm5ic3A7b3BzPGJyIC8+DTxiciAvPiZuYnNw
O2RvYy9ndWlkZXMvbmljcy9mZWF0dXJlcy96eGRoLmluaSZuYnNwOyZuYnNwO3wmbmJzcDsmbmJz
cDsmbmJzcDsxNiZuYnNwOys8YnIgLz4mbmJzcDtkb2MvZ3VpZGVzL25pY3MvenhkaC5yc3QmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7MSZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJz
L25ldC96eGRoL21lc29uLmJ1aWxkJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzEmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVy
cy9uZXQvenhkaC96eGRoX2NvbW1vbi5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOzEmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhk
aC96eGRoX2V0aGRldi5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNw
OyZuYnNwOzI3Jm5ic3A7KzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXYu
aCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsxMyZuYnNw
OystPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldl9vcHMuYyZuYnNwO3wm
bmJzcDsmbmJzcDsmbmJzcDsxMCZuYnNwOystPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96
eGRoX2V0aGRldl9vcHMuaCZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsxJm5ic3A7Kzxi
ciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmMmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7MjAwMyZuYnNwOysrKysrKysrKysrKysrKysr
KysrKysrKysrKys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5oJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOzIzNyZuYnNw
OysrKys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7MjYzJm5ic3A7
KysrLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cuaCZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDszMSZu
YnNwOystPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX25wLmMmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7MTYzOCZuYnNw
OysrKysrKysrKysrKysrKysrKysrKysrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRo
X25wLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MzEmbmJzcDsrLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4
ZGgvenhkaF90YWJsZXMuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJz
cDsmbmJzcDsxMCZuYnNwOystPGJyIC8+Jm5ic3A7MTUmbmJzcDtmaWxlcyZuYnNwO2NoYW5nZWQs
Jm5ic3A7NDIwNyZuYnNwO2luc2VydGlvbnMoKyksJm5ic3A7NzYmbmJzcDtkZWxldGlvbnMoLSk8
YnIgLz4mbmJzcDtjcmVhdGUmbmJzcDttb2RlJm5ic3A7MTAwNjQ0Jm5ic3A7ZHJpdmVycy9uZXQv
enhkaC96eGRoX2Zsb3cuYzxiciAvPiZuYnNwO2NyZWF0ZSZuYnNwO21vZGUmbmJzcDsxMDA2NDQm
bmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5oPGJyIC8+DTxiciAvPi0tJm5ic3A7DTxi
ciAvPjIuMjcuMDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

