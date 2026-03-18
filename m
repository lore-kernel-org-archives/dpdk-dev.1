Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45A310854CE
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 02:49:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C25E8402A0;
	Wed, 18 Mar 2026 03:49:03 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTP id 812794026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 03:49:02 +0100 (CET)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fbCvd32Xpz4yjSf;
 Wed, 18 Mar 2026 10:49:01 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl2.zte.com.cn with SMTP id 62I2mpkx031668;
 Wed, 18 Mar 2026 10:48:51 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 18 Mar 2026 10:48:53 +0800
X-Zmail-TransId: 3e8169ba1290002-5d36c
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: Re: [v3,
 5/5] net/zxdh: add support for GENEVE TSO and Rx outer checksum
Date: Wed, 18 Mar 2026 10:21:59 +0800
Message-ID: <20260318022159.589957-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260131062208.2445121-6-wang.junlong1@zte.com.cn>
References: <20260131062208.2445121-6-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 62I2mpkx031668
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 18 Mar 2026 10:49:01 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69BA129D.000/4fbCvd32Xpz4yjSf
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

U29ycnksIEkgaGF2ZSBhIHF1ZXN0aW9uLg0KU29tZSB0aW1lIGFnbywgSSBzdWJtaXR0ZWQgdGhp
cyBwYXRjaCAoW3YzLDUvNV0gbmV0L3p4ZGg6IGFkZCBzdXBwb3J0IGZvciBHRU5FVkUgVFNPIGFu
ZCBSeCBvdXRlciBjaGVja3N1bSksDQp3aGljaCB3YXMgbWFya2VkIGFzIGFjY2VwdGVkLiBIb3dl
dmVyLCB3aGVuIEkgZmV0Y2hlZCB0aGUgbGF0ZXN0IGRwZC1uZXh0LW5ldCBjb2RlLCB0aGUgZm9y
LW1haW4gYnJhbmNoIGRpZCBub3QgY29udGFpbiBpdC4NCg0KQ291bGQgeW91IHBsZWFzZSBsZXQg
bWUga25vdyBpZiBJIG5lZWQgdG8gcmVzdWJtaXQgdGhpcyBwYXRjaD8NCg0KVGhhbmsgeW91Lg==

--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

U29ycnksJm5ic3A7SSZuYnNwO2hhdmUmbmJzcDthJm5ic3A7cXVlc3Rpb24uPGJyIC8+U29tZSZu
YnNwO3RpbWUmbmJzcDthZ28sJm5ic3A7SSZuYnNwO3N1Ym1pdHRlZCZuYnNwO3RoaXMmbmJzcDtw
YXRjaCZuYnNwOyhbdjMsNS81XSZuYnNwO25ldC96eGRoOiZuYnNwO2FkZCZuYnNwO3N1cHBvcnQm
bmJzcDtmb3ImbmJzcDtHRU5FVkUmbmJzcDtUU08mbmJzcDthbmQmbmJzcDtSeCZuYnNwO291dGVy
Jm5ic3A7Y2hlY2tzdW0pLDxiciAvPndoaWNoJm5ic3A7d2FzJm5ic3A7bWFya2VkJm5ic3A7YXMm
bmJzcDthY2NlcHRlZC4mbmJzcDtIb3dldmVyLCZuYnNwO3doZW4mbmJzcDtJJm5ic3A7ZmV0Y2hl
ZCZuYnNwO3RoZSZuYnNwO2xhdGVzdCZuYnNwO2RwZC1uZXh0LW5ldCZuYnNwO2NvZGUsJm5ic3A7
dGhlJm5ic3A7Zm9yLW1haW4mbmJzcDticmFuY2gmbmJzcDtkaWQmbmJzcDtub3QmbmJzcDtjb250
YWluJm5ic3A7aXQuPGJyIC8+DTxiciAvPkNvdWxkJm5ic3A7eW91Jm5ic3A7cGxlYXNlJm5ic3A7
bGV0Jm5ic3A7bWUmbmJzcDtrbm93Jm5ic3A7aWYmbmJzcDtJJm5ic3A7bmVlZCZuYnNwO3RvJm5i
c3A7cmVzdWJtaXQmbmJzcDt0aGlzJm5ic3A7cGF0Y2g/PGJyIC8+DTxiciAvPlRoYW5rJm5ic3A7
eW91Lg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

