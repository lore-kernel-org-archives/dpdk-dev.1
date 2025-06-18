Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97496C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 01:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BF9140E50;
	Wed, 18 Jun 2025 03:47:13 +0200 (CEST)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id 2D65440279
 for <dev@dpdk.org>; Wed, 18 Jun 2025 03:47:11 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4bMRSD2rr6z51SWR;
 Wed, 18 Jun 2025 09:47:08 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl2.zte.com.cn with SMTP id 55I1knwK094648;
 Wed, 18 Jun 2025 09:46:49 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 18 Jun 2025 09:46:50 +0800
X-Zmail-TransId: 3e8168521a84008-6e92b
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [v2,1/5] net/zxdh: fix meson.build issus in compilation
Date: Wed, 18 Jun 2025 09:41:05 +0800
Message-ID: <20250618014105.3604026-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617020503.3554511-1-wang.junlong1@zte.com.cn>
References: <20250617020503.3554511-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 55I1knwK094648
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68521A9C.001/4bMRSD2rr6z51SWR
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

SGkgTWFpbnRhaW5lciwNCg0KICAgIHllc3RlcmRheSxJIHNhdyB0aGF0IHlvdSBtYXJrZWQgdGhl
IHYyIHNlcmllcyBwYXRjaCBzdGF0dXMgYXMnIENoYW5nZXMgUmVxdWVzdGVkICcsDQogICAgc28g
SSB3b3VsZCBsaWtlIHRvIHN1Ym1pdCBhIG5ldyB2ZXJzaW9uIGFzIHBlciB5b3VyIHJlcXVlc3Qu
DQoNCj4gKiBkcGRrOiBbdjIsMS81XSBuZXQvenhkaDogZml4IG1lc29uLmJ1aWxkIGlzc3VzIGlu
IGNvbXBpbGF0aW9uDQo+ICAgICAtIGh0dHA6Ly9wYXRjaGVzLmRwZGsub3JnL3Byb2plY3QvZHBk
ay9wYXRjaC8yMDI1MDYxNzAyMDUwMy4zNTU0NTExLTEtd2FuZy5qdW5sb25nMUB6dGUuY29tLmNu
Lw0KPiAgICAgLSBmb3I6IERQREsNCj4gICAgd2FzOiBVbmRlciBSZXZpZXcNCj4gICAgbm93OiBD
aGFuZ2VzIFJlcXVlc3RlZA0KDQogICAgQnV0IEkgZm91bmQgdGhhdCB0aGUgdjIgc2VyaWVzIHBh
dGNoZXMgYXJlIGluIHRoZSBtZXJnZWQgc3RhdGUgd2hlbiB1c2luZyAnZ2l0IHB1bGwgLXIgJiYg
Z2l0IGxvZycgbG9jYWxseS4NCiAgICBTbywgd2hhdCBkbyBJIG5lZWQgdG8gZG8gbm93Lg0KDQog
ICAgVGhhbmsgeW91IGZvciB5b3VyIHRpbWUgYW5kIGF0dGVudGlvbiByZWdhcmRpbmcgdGhpcyBt
YXR0ZXIu


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGkmbmJzcDtNYWludGFpbmVyLDxiciAvPg08YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt5
ZXN0ZXJkYXksSSZuYnNwO3NhdyZuYnNwO3RoYXQmbmJzcDt5b3UmbmJzcDttYXJrZWQmbmJzcDt0
aGUmbmJzcDt2MiZuYnNwO3NlcmllcyZuYnNwO3BhdGNoJm5ic3A7c3RhdHVzJm5ic3A7YXMmYXBv
czsmbmJzcDtDaGFuZ2VzJm5ic3A7UmVxdWVzdGVkJm5ic3A7JmFwb3M7LDxiciAvPiZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwO3NvJm5ic3A7SSZuYnNwO3dvdWxkJm5ic3A7bGlrZSZuYnNwO3RvJm5i
c3A7c3VibWl0Jm5ic3A7YSZuYnNwO25ldyZuYnNwO3ZlcnNpb24mbmJzcDthcyZuYnNwO3BlciZu
YnNwO3lvdXImbmJzcDtyZXF1ZXN0LjxiciAvPg08YnIgLz4mZ3Q7Jm5ic3A7KiZuYnNwO2RwZGs6
Jm5ic3A7W3YyLDEvNV0mbmJzcDtuZXQvenhkaDombmJzcDtmaXgmbmJzcDttZXNvbi5idWlsZCZu
YnNwO2lzc3VzJm5ic3A7aW4mbmJzcDtjb21waWxhdGlvbjxiciAvPiZndDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDstJm5ic3A7aHR0cDovL3BhdGNoZXMuZHBkay5vcmcvcHJvamVjdC9k
cGRrL3BhdGNoLzIwMjUwNjE3MDIwNTAzLjM1NTQ1MTEtMS13YW5nLmp1bmxvbmcxQHp0ZS5jb20u
Y24vPGJyIC8+Jmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy0mbmJzcDtmb3I6Jm5i
c3A7RFBESzxiciAvPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt3YXM6Jm5ic3A7VW5kZXIm
bmJzcDtSZXZpZXc8YnIgLz4mZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7bm93OiZuYnNwO0No
YW5nZXMmbmJzcDtSZXF1ZXN0ZWQ8YnIgLz4NPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
QnV0Jm5ic3A7SSZuYnNwO2ZvdW5kJm5ic3A7dGhhdCZuYnNwO3RoZSZuYnNwO3YyJm5ic3A7c2Vy
aWVzJm5ic3A7cGF0Y2hlcyZuYnNwO2FyZSZuYnNwO2luJm5ic3A7dGhlJm5ic3A7bWVyZ2VkJm5i
c3A7c3RhdGUmbmJzcDt3aGVuJm5ic3A7dXNpbmcmbmJzcDsmYXBvcztnaXQmbmJzcDtwdWxsJm5i
c3A7LXImbmJzcDsmYW1wOyZhbXA7Jm5ic3A7Z2l0Jm5ic3A7bG9nJmFwb3M7Jm5ic3A7bG9jYWxs
eS48YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtTbywmbmJzcDt3aGF0Jm5ic3A7ZG8mbmJz
cDtJJm5ic3A7bmVlZCZuYnNwO3RvJm5ic3A7ZG8mbmJzcDtub3cuPGJyIC8+DTxiciAvPiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwO1RoYW5rJm5ic3A7eW91Jm5ic3A7Zm9yJm5ic3A7eW91ciZuYnNw
O3RpbWUmbmJzcDthbmQmbmJzcDthdHRlbnRpb24mbmJzcDtyZWdhcmRpbmcmbmJzcDt0aGlzJm5i
c3A7bWF0dGVyLiZuYnNwOyZuYnNwOw==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

