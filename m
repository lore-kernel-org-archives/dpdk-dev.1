Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAFDD711D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 10:46:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EB7540611;
	Mon, 22 Dec 2025 11:46:21 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTP id 2A3C840264
 for <dev@dpdk.org>; Mon, 22 Dec 2025 11:46:20 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dZZZ249Msz6FyBs;
 Mon, 22 Dec 2025 18:46:18 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl1.zte.com.cn with SMTP id 5BMAk3oe085215;
 Mon, 22 Dec 2025 18:46:03 +0800 (+08)
 (envelope-from zhang.tianhao2@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Mon, 22 Dec 2025 18:46:06 +0800
X-Zmail-TransId: 3e816949215b000-23408
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: zhang.tianhao2@zte.com.cn
From: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Subject: [PATCH v1 0/2] fix bug
Date: Mon, 22 Dec 2025 18:25:33 +0800
Message-ID: <20251222102535.401064-1-zhang.tianhao2@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209021609.3911854-1-zhang.tianhao2@zte.com.cn>
References: <20251209021609.3911854-1-zhang.tianhao2@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 5BMAk3oe085215
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.tianhao2@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 22 Dec 2025 18:46:18 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6949217A.000/4dZZZ249Msz6FyBs
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

VjE6DQogIC0gQWRkIHBjaWUgYmFyIGNoYW5uZWwgY2hlY2sgYWZ0ZXIgZ2V0dGluZyBkdGIgc3Bh
Y2UgbGVmdC4NCiAgLSBEZWxldGUgbnAgc29mdCByZXNvdXJjZSB1bmluc3RhbGxhdGlvbiBmcm9t
IE5QIG9ubGluZSB1bmluaXQgcHJvY2Vzcy4NCg0KVGlhbmhhbyBaaGFuZyAoMik6DQogIG5ldC96
eGRoOiBhZGQgcGNpZSBiYXIgY2hhbm5lbCBjaGVjaw0KICBuZXQvenhkaDogZGVsZXRlIG5wIHNv
ZnQgcmVzb3VyY2UgdW5pbnN0YWxsYXRpb24NCg0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5j
IHwgMTEgKysrKysrKy0tLS0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuaCB8ICAyICsrDQog
MiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCi0tIA0K
Mi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjE6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO0FkZCZuYnNwO3BjaWUmbmJzcDtiYXImbmJzcDtj
aGFubmVsJm5ic3A7Y2hlY2smbmJzcDthZnRlciZuYnNwO2dldHRpbmcmbmJzcDtkdGImbmJzcDtz
cGFjZSZuYnNwO2xlZnQuPGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO0RlbGV0ZSZuYnNwO25wJm5i
c3A7c29mdCZuYnNwO3Jlc291cmNlJm5ic3A7dW5pbnN0YWxsYXRpb24mbmJzcDtmcm9tJm5ic3A7
TlAmbmJzcDtvbmxpbmUmbmJzcDt1bmluaXQmbmJzcDtwcm9jZXNzLjxiciAvPg08YnIgLz5UaWFu
aGFvJm5ic3A7WmhhbmcmbmJzcDsoMik6PGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7
YWRkJm5ic3A7cGNpZSZuYnNwO2JhciZuYnNwO2NoYW5uZWwmbmJzcDtjaGVjazxiciAvPiZuYnNw
OyZuYnNwO25ldC96eGRoOiZuYnNwO2RlbGV0ZSZuYnNwO25wJm5ic3A7c29mdCZuYnNwO3Jlc291
cmNlJm5ic3A7dW5pbnN0YWxsYXRpb248YnIgLz4NPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhk
aC96eGRoX25wLmMmbmJzcDt8Jm5ic3A7MTEmbmJzcDsrKysrKysrLS0tLTxiciAvPiZuYnNwO2Ry
aXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5oJm5ic3A7fCZuYnNwOyZuYnNwOzImbmJzcDsrKzxiciAv
PiZuYnNwOzImbmJzcDtmaWxlcyZuYnNwO2NoYW5nZWQsJm5ic3A7OSZuYnNwO2luc2VydGlvbnMo
KyksJm5ic3A7NCZuYnNwO2RlbGV0aW9ucygtKTxiciAvPg08YnIgLz4tLSZuYnNwOw08YnIgLz4y
LjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

