Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3228AC35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 09:47:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 472D04026B;
	Wed, 19 Mar 2025 10:47:15 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
 by mails.dpdk.org (Postfix) with ESMTP id EE8874025A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 10:47:13 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZHkQ81vVgz5B1G1;
 Wed, 19 Mar 2025 17:47:12 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl1.zte.com.cn with SMTP id 52J9kd3U034734;
 Wed, 19 Mar 2025 17:46:39 +0800 (+08)
 (envelope-from chen.bingbin@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 19 Mar 2025 17:46:42 +0800
X-Zmail-TransId: 3e8167da9279007-cccef
From: Bingbin Chen <chen.bingbin@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: Re: [v5,00/14] net/zxdh: add network processor ops
Date: Wed, 19 Mar 2025 17:31:35 +0800
Message-ID: <20250319093135.1913952-1-chen.bingbin@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319085808.1912523-1-chen.bingbin@zte.com.cn>
References: <20250319085808.1912523-1-chen.bingbin@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 52J9kd3U034734
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67DA92A0.000/4ZHkQ81vVgz5B1G1
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

SGksIG1haW50YWluZXI6DQoNClRoaXMgc3VibWlzc2lvbiBoYXMgbWFkZSBtb2RpZmljYXRpb25z
IGJhc2VkIG9uIHRoZSBjb21tZW50cy4NCg0KQWZ0ZXIgdGhpcyByb3VuZCBvZiBzdWJtaXNzaW9u
LCB0aGUgYmFzaWMgZnVuY3Rpb25zIG9mIHRoZSB6eGRoIGRyaXZlciB3aWxsIGJlIGNvbXBsZXRl
Lg0KDQpTdWJzZXF1ZW50IG1lcmdlcyB3aWxsIG1haW5seSBmb2N1cyBvbiBGRCBmdW5jdGlvbiBz
dXBwbGVtZW50cyBhbmQgYnVnIGZpeGVzLg0KDQpUaGFua3Mu


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGksJm5ic3A7bWFpbnRhaW5lcjo8YnIgLz4NPGJyIC8+VGhpcyZuYnNwO3N1Ym1pc3Npb24mbmJz
cDtoYXMmbmJzcDttYWRlJm5ic3A7bW9kaWZpY2F0aW9ucyZuYnNwO2Jhc2VkJm5ic3A7b24mbmJz
cDt0aGUmbmJzcDtjb21tZW50cy48YnIgLz4NPGJyIC8+QWZ0ZXImbmJzcDt0aGlzJm5ic3A7cm91
bmQmbmJzcDtvZiZuYnNwO3N1Ym1pc3Npb24sJm5ic3A7dGhlJm5ic3A7YmFzaWMmbmJzcDtmdW5j
dGlvbnMmbmJzcDtvZiZuYnNwO3RoZSZuYnNwO3p4ZGgmbmJzcDtkcml2ZXImbmJzcDt3aWxsJm5i
c3A7YmUmbmJzcDtjb21wbGV0ZS48YnIgLz4NPGJyIC8+U3Vic2VxdWVudCZuYnNwO21lcmdlcyZu
YnNwO3dpbGwmbmJzcDttYWlubHkmbmJzcDtmb2N1cyZuYnNwO29uJm5ic3A7RkQmbmJzcDtmdW5j
dGlvbiZuYnNwO3N1cHBsZW1lbnRzJm5ic3A7YW5kJm5ic3A7YnVnJm5ic3A7Zml4ZXMuPGJyIC8+
DTxiciAvPlRoYW5rcy4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

