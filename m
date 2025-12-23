Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A25E6F079
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 11:16:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55C7440265;
	Tue, 23 Dec 2025 12:16:13 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTP id 9A2DB4025A
 for <dev@dpdk.org>; Tue, 23 Dec 2025 12:16:11 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dbCB22XqNz6FyBv;
 Tue, 23 Dec 2025 19:16:10 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 5BNBFh77022984;
 Tue, 23 Dec 2025 19:15:43 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Tue, 23 Dec 2025 19:15:46 +0800
X-Zmail-TransId: 3e81694a79dd000-3f582
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 4/5] net/zxdh: add support primary/secondary process
Date: Tue, 23 Dec 2025 18:55:25 +0800
Message-ID: <20251223105525.460420-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251220061521.289722-5-wang.junlong1@zte.com.cn>
References: <20251220061521.289722-5-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 5BNBFh77022984
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 23 Dec 2025 19:16:10 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 694A79FA.001/4dbCB22XqNz6FyBv
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

PiBEb2VzIHRoaXMgZHJpdmVyIHN1cHBvcnQgZ2V0dGluZyBzdGF0cyBpbiB0aGUgc2Vjb25kYXJ5
IHByb2Nlc3M/DQo+IFRoZXJlIGFyZSBzb21lIE5ldHdvcmsgVmlydHVhbCBBcHBsaWFuY2UgcHJv
ZHVjdHMgdGhhdCBydW4gd2l0aCBhbGwgdGhlDQo+IHdvcmsgYmVpbmcgZG9uZSBieSBzZWNvbmRh
cnkgcHJvY2VzcyBhbmQgb25seSB1c2UgdGhlIHByaW1hcnkgYXMgYSB3YXRjaGRvZyBmb3IgcmVz
dGFydC4NCg0KWWVzLCBpdCBjYW4gZ2V0dGluZyBzdGF0cyBpbiB0aGUgc2Vjb25kYXJ5IHByb2Nl
c3MuDQpEdWUgdG8gc29tZSBkZXNpZ24gcHJvYmxlbSwgc3VjaCBhcyB0aGUgaGFyZHdhcmUgbG9j
ayBpbiB0aGUgbXNnIGJhciBzcGFjZSwNCnRoZSB6eGRoIGRyaXZlciBjYW5ub3QgcnVuIGFsbCB3
b3JrIGluIHRoZSBzZWNvbmRhcnkgcHJvY2Vzcy4=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Jmd0OyZuYnNwO0RvZXMmbmJzcDt0aGlzJm5ic3A7ZHJpdmVyJm5ic3A7c3VwcG9ydCZuYnNwO2dl
dHRpbmcmbmJzcDtzdGF0cyZuYnNwO2luJm5ic3A7dGhlJm5ic3A7c2Vjb25kYXJ5Jm5ic3A7cHJv
Y2Vzcz88YnIgLz4mZ3Q7Jm5ic3A7VGhlcmUmbmJzcDthcmUmbmJzcDtzb21lJm5ic3A7TmV0d29y
ayZuYnNwO1ZpcnR1YWwmbmJzcDtBcHBsaWFuY2UmbmJzcDtwcm9kdWN0cyZuYnNwO3RoYXQmbmJz
cDtydW4mbmJzcDt3aXRoJm5ic3A7YWxsJm5ic3A7dGhlPGJyIC8+Jmd0OyZuYnNwO3dvcmsmbmJz
cDtiZWluZyZuYnNwO2RvbmUmbmJzcDtieSZuYnNwO3NlY29uZGFyeSZuYnNwO3Byb2Nlc3MmbmJz
cDthbmQmbmJzcDtvbmx5Jm5ic3A7dXNlJm5ic3A7dGhlJm5ic3A7cHJpbWFyeSZuYnNwO2FzJm5i
c3A7YSZuYnNwO3dhdGNoZG9nJm5ic3A7Zm9yJm5ic3A7cmVzdGFydC48YnIgLz4NPGJyIC8+WWVz
LCZuYnNwO2l0Jm5ic3A7Y2FuJm5ic3A7Z2V0dGluZyZuYnNwO3N0YXRzJm5ic3A7aW4mbmJzcDt0
aGUmbmJzcDtzZWNvbmRhcnkmbmJzcDtwcm9jZXNzLjxiciAvPkR1ZSZuYnNwO3RvJm5ic3A7c29t
ZSZuYnNwO2Rlc2lnbiZuYnNwO3Byb2JsZW0sJm5ic3A7c3VjaCZuYnNwO2FzJm5ic3A7dGhlJm5i
c3A7aGFyZHdhcmUmbmJzcDtsb2NrJm5ic3A7aW4mbmJzcDt0aGUmbmJzcDttc2cmbmJzcDtiYXIm
bmJzcDtzcGFjZSw8YnIgLz50aGUmbmJzcDt6eGRoJm5ic3A7ZHJpdmVyJm5ic3A7Y2Fubm90Jm5i
c3A7cnVuJm5ic3A7YWxsJm5ic3A7d29yayZuYnNwO2luJm5ic3A7dGhlJm5ic3A7c2Vjb25kYXJ5
Jm5ic3A7cHJvY2Vzcy48YnIgLz4NPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

