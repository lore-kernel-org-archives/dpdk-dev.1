Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8669CD4851
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 08:44:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49AE940615;
	Fri, 15 May 2026 10:43:58 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTP id 49FC3400EF
 for <dev@dpdk.org>; Fri, 15 May 2026 10:43:56 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gH12G5ydSz5B0rY
 for <dev@dpdk.org>; Fri, 15 May 2026 16:43:50 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl2.zte.com.cn with SMTP id 64F8hcX8059563
 for <dev@dpdk.org>; Fri, 15 May 2026 16:43:38 +0800 (+08)
 (envelope-from han.chengfei@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Fri, 15 May 2026 16:43:40 +0800
X-Zmail-TransId: 3e816a06dcb6002-650b2
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: han.chengfei@zte.com.cn
From: Chengfei Han <han.chengfei@zte.com.cn>
To: dev@dpdk.org
Cc: ran.ming@zte.com.cn, Chengfei Han <han.chengfei@zte.com.cn>
Subject: [PATCH 0/1] crypto/zsda: update product name and maintainer
Date: Fri, 15 May 2026 16:12:11 +0800
Message-ID: <20260515081212.3565572-1-han.chengfei@zte.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 64F8hcX8059563
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: han.chengfei@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 15 May 2026 16:43:50 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A06DCC6.001/4gH12G5ydSz5B0rY
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

KioqIEJMVVJCIEhFUkUgKioqDQoNClRoaXMgcGF0Y2ggdXBkYXRlcyB0aGUgWlNEQSBQTUQgZHJp
dmVyOg0KLSBDb3JyZWN0IHByb2R1Y3QgbmFtZSBmcm9tICcxY2YyJyB0byAnTmVvIFg1MTAvWDUx
MicgaW4gZG9jdW1lbnRhdGlvbg0KLSBVcGRhdGUgbWFpbnRhaW5lciBmb3IgWlRFIFN0b3JhZ2Ug
RGF0YSBBY2NlbGVyYXRvciAoWlNEQSkNCg0KQ2hlbmdmZWkgSGFuICgxKToNCiAgY3J5cHRvL3pz
ZGE6IFVwZGF0ZSBwcm9kdWN0IG5hbWUgYW5kIG1haW50YWluZXINCg0KIE1BSU5UQUlORVJTICAg
ICAgICAgICAgICAgICAgICAgIHwgMyArKy0NCiBkb2MvZ3VpZGVzL2NvbXByZXNzZGV2cy96c2Rh
LnJzdCB8IDMgKy0tDQogZG9jL2d1aWRlcy9jcnlwdG9kZXZzL3pzZGEucnN0ICAgfCAzICstLQ0K
IDMgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQotLSAN
CjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

KioqJm5ic3A7QkxVUkImbmJzcDtIRVJFJm5ic3A7KioqPGJyIC8+DTxiciAvPlRoaXMmbmJzcDtw
YXRjaCZuYnNwO3VwZGF0ZXMmbmJzcDt0aGUmbmJzcDtaU0RBJm5ic3A7UE1EJm5ic3A7ZHJpdmVy
OjxiciAvPi0mbmJzcDtDb3JyZWN0Jm5ic3A7cHJvZHVjdCZuYnNwO25hbWUmbmJzcDtmcm9tJm5i
c3A7JmFwb3M7MWNmMiZhcG9zOyZuYnNwO3RvJm5ic3A7JmFwb3M7TmVvJm5ic3A7WDUxMC9YNTEy
JmFwb3M7Jm5ic3A7aW4mbmJzcDtkb2N1bWVudGF0aW9uPGJyIC8+LSZuYnNwO1VwZGF0ZSZuYnNw
O21haW50YWluZXImbmJzcDtmb3ImbmJzcDtaVEUmbmJzcDtTdG9yYWdlJm5ic3A7RGF0YSZuYnNw
O0FjY2VsZXJhdG9yJm5ic3A7KFpTREEpPGJyIC8+DTxiciAvPkNoZW5nZmVpJm5ic3A7SGFuJm5i
c3A7KDEpOjxiciAvPiZuYnNwOyZuYnNwO2NyeXB0by96c2RhOiZuYnNwO1VwZGF0ZSZuYnNwO3By
b2R1Y3QmbmJzcDtuYW1lJm5ic3A7YW5kJm5ic3A7bWFpbnRhaW5lcjxiciAvPg08YnIgLz4mbmJz
cDtNQUlOVEFJTkVSUyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDszJm5ic3A7KystPGJyIC8+Jm5i
c3A7ZG9jL2d1aWRlcy9jb21wcmVzc2RldnMvenNkYS5yc3QmbmJzcDt8Jm5ic3A7MyZuYnNwOyst
LTxiciAvPiZuYnNwO2RvYy9ndWlkZXMvY3J5cHRvZGV2cy96c2RhLnJzdCZuYnNwOyZuYnNwOyZu
YnNwO3wmbmJzcDszJm5ic3A7Ky0tPGJyIC8+Jm5ic3A7MyZuYnNwO2ZpbGVzJm5ic3A7Y2hhbmdl
ZCwmbmJzcDs0Jm5ic3A7aW5zZXJ0aW9ucygrKSwmbmJzcDs1Jm5ic3A7ZGVsZXRpb25zKC0pPGJy
IC8+DTxiciAvPi0tJm5ic3A7DTxiciAvPjIuMjcuMDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

