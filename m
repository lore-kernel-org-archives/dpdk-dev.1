Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458E4C5AE59
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 07:40:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECCCA40648;
	Wed, 28 May 2025 09:40:42 +0200 (CEST)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id E0DB840279
 for <dev@dpdk.org>; Wed, 28 May 2025 09:40:41 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4b6hHl4kB5z4x5rk
 for <dev@dpdk.org>; Wed, 28 May 2025 15:40:35 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl1.zte.com.cn with SMTP id 54S7eBen021191
 for <dev@dpdk.org>; Wed, 28 May 2025 15:40:11 +0800 (+08)
 (envelope-from li.hanxiao@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 28 May 2025 15:40:14 +0800
X-Zmail-TransId: 3e816836bdce006-3fd03
From: Hanxiao Li <li.hanxiao@zte.com.cn>
To: dev@dpdk.org
Cc: Hanxiao Li <li.hanxiao@zte.com.cn>
Subject: [PATCH v1 0/1] compress/zsda: code cleanup
Date: Wed, 28 May 2025 15:35:52 +0800
Message-ID: <20250528073553.2567982-1-li.hanxiao@zte.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 54S7eBen021191
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6836BDF3.001/4b6hHl4kB5z4x5rk
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

djE6DQotIHN1Ym1pdCBwYXRjaA0KDQoNCkhhbnhpYW8gTGkgKDEpOg0KICBjb21wcmVzcy96c2Rh
OiBjb21wcmVzcyBjb2RlIGNsZWFudXANCg0KIGRyaXZlcnMvY29tbW9uL3pzZGEvenNkYV9kZXZp
Y2UuYyAgICAgfCAgMyArLQ0KIGRyaXZlcnMvY29tbW9uL3pzZGEvenNkYV9kZXZpY2UuaCAgICAg
fCAgNiArLS0NCiBkcml2ZXJzL2NvbW1vbi96c2RhL3pzZGFfcXAuaCAgICAgICAgIHwgNDggKysr
KysrKysrLS0tLS0tLS0tDQogZHJpdmVycy9jb21tb24venNkYS96c2RhX3FwX2NvbW1vbi5oICB8
IDQzICsrKysrKystLS0tLS0tLS0NCiBkcml2ZXJzL2NvbXByZXNzL3pzZGEvenNkYV9jb21wLmMg
ICAgIHwgIDIgKy0NCiBkcml2ZXJzL2NvbXByZXNzL3pzZGEvenNkYV9jb21wLmggICAgIHwgIDIg
Ky0NCiBkcml2ZXJzL2NvbXByZXNzL3pzZGEvenNkYV9jb21wX3BtZC5jIHwgNzMgKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tDQogZHJpdmVycy9jb21wcmVzcy96c2RhL3pzZGFfY29tcF9wbWQu
aCB8IDEyICsrKy0tDQogOCBmaWxlcyBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspLCA5MyBkZWxl
dGlvbnMoLSkNCg0KLS0NCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

djE6PGJyIC8+LSZuYnNwO3N1Ym1pdCZuYnNwO3BhdGNoPGJyIC8+DTxiciAvPg08YnIgLz5IYW54
aWFvJm5ic3A7TGkmbmJzcDsoMSk6PGJyIC8+Jm5ic3A7Jm5ic3A7Y29tcHJlc3MvenNkYTombmJz
cDtjb21wcmVzcyZuYnNwO2NvZGUmbmJzcDtjbGVhbnVwPGJyIC8+DTxiciAvPiZuYnNwO2RyaXZl
cnMvY29tbW9uL3pzZGEvenNkYV9kZXZpY2UuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
O3wmbmJzcDsmbmJzcDszJm5ic3A7Ky08YnIgLz4mbmJzcDtkcml2ZXJzL2NvbW1vbi96c2RhL3pz
ZGFfZGV2aWNlLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7NiZu
YnNwOystLTxiciAvPiZuYnNwO2RyaXZlcnMvY29tbW9uL3pzZGEvenNkYV9xcC5oJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOzQ4Jm5i
c3A7KysrKysrKysrLS0tLS0tLS0tPGJyIC8+Jm5ic3A7ZHJpdmVycy9jb21tb24venNkYS96c2Rh
X3FwX2NvbW1vbi5oJm5ic3A7Jm5ic3A7fCZuYnNwOzQzJm5ic3A7KysrKysrKy0tLS0tLS0tLTxi
ciAvPiZuYnNwO2RyaXZlcnMvY29tcHJlc3MvenNkYS96c2RhX2NvbXAuYyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsyJm5ic3A7Ky08YnIgLz4mbmJzcDtkcml2ZXJz
L2NvbXByZXNzL3pzZGEvenNkYV9jb21wLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8
Jm5ic3A7Jm5ic3A7MiZuYnNwOystPGJyIC8+Jm5ic3A7ZHJpdmVycy9jb21wcmVzcy96c2RhL3pz
ZGFfY29tcF9wbWQuYyZuYnNwO3wmbmJzcDs3MyZuYnNwOysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLTxiciAvPiZuYnNwO2RyaXZlcnMvY29tcHJlc3MvenNkYS96c2RhX2NvbXBfcG1kLmgmbmJz
cDt8Jm5ic3A7MTImbmJzcDsrKystLTxiciAvPiZuYnNwOzgmbmJzcDtmaWxlcyZuYnNwO2NoYW5n
ZWQsJm5ic3A7OTYmbmJzcDtpbnNlcnRpb25zKCspLCZuYnNwOzkzJm5ic3A7ZGVsZXRpb25zKC0p
PGJyIC8+DTxiciAvPi0tPGJyIC8+Mi4yNy4wPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

