Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7766CC54756
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 08:21:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F8D3402C2;
	Thu, 22 May 2025 10:21:26 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
 by mails.dpdk.org (Postfix) with ESMTP id 39787402B9
 for <dev@dpdk.org>; Thu, 22 May 2025 10:21:25 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4b31TX6Qvcz8R043;
 Thu, 22 May 2025 16:21:20 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl1.zte.com.cn with SMTP id 54M8KxAO028040;
 Thu, 22 May 2025 16:20:59 +0800 (+08)
 (envelope-from li.hanxiao@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 22 May 2025 16:21:02 +0800
X-Zmail-TransId: 3e81682ede5f005-80f11
From: Hanxiao Li <li.hanxiao@zte.com.cn>
To: dev@dpdk.org, gakhil@marvell.com
Subject: Re: [v5,1/9] crypto/zsda: add skeleton
Date: Thu, 22 May 2025 16:17:12 +0800
Message-ID: <20250522081712.2270938-1-li.hanxiao@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522064616.2267636-2-li.hanxiao@zte.com.cn>
References: <20250522064616.2267636-2-li.hanxiao@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 54M8KxAO028040
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 682EDE80.001/4b31TX6Qvcz8R043
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

SGkgYWtoaWw6DQoNClRoZXJlIGlzIGEgY3JpdGljYWwgd2FybmluZywgbWF5YmUgY2FuIGNhbGxl
ZCBlcnJvciwgdGhhdCB0aGUgcGF0Y2hlcyBjYW4ndCBiZSBhcHBsaWVkLg0KDQpCZWNhdXNlIEkg
Zm9ybWF0dGVkIHNvbWUgZmlsZXMgaW4gcGF0Y2ggIlt2MV0gY29tcHJlc3MvenNkYTogY29kZSBm
b3JtYXR0aW5nIiwgd2hvc2UgbGluayBpcyANCmh0dHBzOi8vcGF0Y2hlcy5kcGRrLm9yZy9wcm9q
ZWN0L2RwZGsvcGF0Y2gvMjAyNTA1MjIwNjIzNTEuMjI2Njc3Ni0xLWxpLmhhbnhpYW9AenRlLmNv
bS5jbi8NCg0KVGhlIGNyeXB0byBwYXRjaGVzIHdlcmUgY2hhbmdlZCBiYXNlZCBvbiB0aGUgW3Yx
XSBwYXRjaC4NCg0KU28gZG8gSSBuZWVkIHRvIHJlc3VibWl0IHRoZSBjcnlwdG8gcGF0Y2hlcyBh
ZnRlciB5b3UgYWNjZXB0ZWQgdGhlIFt2MV0gcGF0Y2g/


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGkmbmJzcDtha2hpbDo8YnIgLz4NPGJyIC8+VGhlcmUmbmJzcDtpcyZuYnNwO2EmbmJzcDtjcml0
aWNhbCZuYnNwO3dhcm5pbmcsJm5ic3A7bWF5YmUmbmJzcDtjYW4mbmJzcDtjYWxsZWQmbmJzcDtl
cnJvciwmbmJzcDt0aGF0Jm5ic3A7dGhlJm5ic3A7cGF0Y2hlcyZuYnNwO2NhbiZhcG9zO3QmbmJz
cDtiZSZuYnNwO2FwcGxpZWQuPGJyIC8+DTxiciAvPkJlY2F1c2UmbmJzcDtJJm5ic3A7Zm9ybWF0
dGVkJm5ic3A7c29tZSZuYnNwO2ZpbGVzJm5ic3A7aW4mbmJzcDtwYXRjaCZuYnNwOyZxdW90O1t2
MV0mbmJzcDtjb21wcmVzcy96c2RhOiZuYnNwO2NvZGUmbmJzcDtmb3JtYXR0aW5nJnF1b3Q7LCZu
YnNwO3dob3NlJm5ic3A7bGluayZuYnNwO2lzJm5ic3A7DTxiciAvPmh0dHBzOi8vcGF0Y2hlcy5k
cGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNTA1MjIwNjIzNTEuMjI2Njc3Ni0xLWxpLmhh
bnhpYW9AenRlLmNvbS5jbi88YnIgLz4NPGJyIC8+VGhlJm5ic3A7Y3J5cHRvJm5ic3A7cGF0Y2hl
cyZuYnNwO3dlcmUmbmJzcDtjaGFuZ2VkJm5ic3A7YmFzZWQmbmJzcDtvbiZuYnNwO3RoZSZuYnNw
O1t2MV0mbmJzcDtwYXRjaC48YnIgLz4NPGJyIC8+U28mbmJzcDtkbyZuYnNwO0kmbmJzcDtuZWVk
Jm5ic3A7dG8mbmJzcDtyZXN1Ym1pdCZuYnNwO3RoZSZuYnNwO2NyeXB0byZuYnNwO3BhdGNoZXMm
bmJzcDthZnRlciZuYnNwO3lvdSZuYnNwO2FjY2VwdGVkJm5ic3A7dGhlJm5ic3A7W3YxXSZuYnNw
O3BhdGNoPw==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

