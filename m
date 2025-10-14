Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C65CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:43:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9E9240668;
	Tue, 14 Oct 2025 14:43:24 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 6F71C40665
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:43:23 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cmDQy1WVCz8Xs7s
 for <dev@dpdk.org>; Tue, 14 Oct 2025 20:43:22 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl2.zte.com.cn with SMTP id 59ECh7Ts067931
 for <dev@dpdk.org>; Tue, 14 Oct 2025 20:43:07 +0800 (+08)
 (envelope-from zhang.tianhao2@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Tue, 14 Oct 2025 20:43:10 +0800
X-Zmail-TransId: 3e8168ee4558008-d7a83
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: zhang.tianhao2@zte.com.cn
From: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
To: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn
Cc: dev@dpdk.org
Subject: Re: [v2] net/zxdh: support multiple PF process flow table
Date: Tue, 14 Oct 2025 20:28:14 +0800
Message-ID: <20251014122814.1071534-1-zhang.tianhao2@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926012806.127837-1-zhang.tianhao2@zte.com.cn>
References: <20250926012806.127837-1-zhang.tianhao2@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 59ECh7Ts067931
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.tianhao2@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 14 Oct 2025 20:43:22 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68EE456A.000/4cmDQy1WVCz8Xs7s
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

SGkgU3RlcGhlbiwNCg0KUmVnYXJkaW5nIHlvdXIgdmFsdWFibGUgcmV2aWV3IGNvbW1lbnRzIG9u
IHRoZSBmaXJzdCB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBJIHN1Ym1pdHRlZCwgSSBoYXZlIG1hZGUg
dGhlIGNvcnJlc3BvbmRpbmcgcmV2aXNpb25zIGFuZCBzdWJtaXR0ZWQgdGhlIHNlY29uZCB2ZXJz
aW9uIG9uIFNlcHRlbWJlciAyNi4gSG93ZXZlciwgSSBoYXZlIGJlZW4gd2FpdGluZyBmb3IgdGhy
ZWUgd2Vla3Mgd2l0aG91dCByZWNlaXZpbmcgeW91ciByZXZpZXcgZmVlZGJhY2sgeWV0LiBJIHdv
dWxkIGFwcHJlY2lhdGUgaXQgaWYgeW91IGNvdWxkIHJldmlldyB0aGUgc2Vjb25kIHZlcnNpb24g
b2YgdGhlIHBhdGNoIEkgc3VibWl0dGVkLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgdGltZSBhbmQg
Y29uc2lkZXJhdGlvbi4NCg0KQmVzdCByZWdhcmRzLA0KWmhhbmcgVGlhbmhhbw==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGkmbmJzcDtTdGVwaGVuLDxiciAvPg08YnIgLz5SZWdhcmRpbmcmbmJzcDt5b3VyJm5ic3A7dmFs
dWFibGUmbmJzcDtyZXZpZXcmbmJzcDtjb21tZW50cyZuYnNwO29uJm5ic3A7dGhlJm5ic3A7Zmly
c3QmbmJzcDt2ZXJzaW9uJm5ic3A7b2YmbmJzcDt0aGUmbmJzcDtwYXRjaCZuYnNwO0kmbmJzcDtz
dWJtaXR0ZWQsJm5ic3A7SSZuYnNwO2hhdmUmbmJzcDttYWRlJm5ic3A7dGhlJm5ic3A7Y29ycmVz
cG9uZGluZyZuYnNwO3JldmlzaW9ucyZuYnNwO2FuZCZuYnNwO3N1Ym1pdHRlZCZuYnNwO3RoZSZu
YnNwO3NlY29uZCZuYnNwO3ZlcnNpb24mbmJzcDtvbiZuYnNwO1NlcHRlbWJlciZuYnNwOzI2LiZu
YnNwO0hvd2V2ZXIsJm5ic3A7SSZuYnNwO2hhdmUmbmJzcDtiZWVuJm5ic3A7d2FpdGluZyZuYnNw
O2ZvciZuYnNwO3RocmVlJm5ic3A7d2Vla3MmbmJzcDt3aXRob3V0Jm5ic3A7cmVjZWl2aW5nJm5i
c3A7eW91ciZuYnNwO3JldmlldyZuYnNwO2ZlZWRiYWNrJm5ic3A7eWV0LiZuYnNwO0kmbmJzcDt3
b3VsZCZuYnNwO2FwcHJlY2lhdGUmbmJzcDtpdCZuYnNwO2lmJm5ic3A7eW91Jm5ic3A7Y291bGQm
bmJzcDtyZXZpZXcmbmJzcDt0aGUmbmJzcDtzZWNvbmQmbmJzcDt2ZXJzaW9uJm5ic3A7b2YmbmJz
cDt0aGUmbmJzcDtwYXRjaCZuYnNwO0kmbmJzcDtzdWJtaXR0ZWQuPGJyIC8+DTxiciAvPlRoYW5r
Jm5ic3A7eW91Jm5ic3A7Zm9yJm5ic3A7eW91ciZuYnNwO3RpbWUmbmJzcDthbmQmbmJzcDtjb25z
aWRlcmF0aW9uLjxiciAvPg08YnIgLz5CZXN0Jm5ic3A7cmVnYXJkcyw8YnIgLz5aaGFuZyZuYnNw
O1RpYW5oYW8=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

