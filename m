Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84882CCD19F
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 07:11:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6700D4060C;
	Tue, 21 Oct 2025 09:11:57 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTP id B62F14060F
 for <dev@dpdk.org>; Tue, 21 Oct 2025 09:11:55 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4crNlF4M7zz6FyBr;
 Tue, 21 Oct 2025 15:11:53 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl2.zte.com.cn with SMTP id 59L7BXtJ005305;
 Tue, 21 Oct 2025 15:11:33 +0800 (+08)
 (envelope-from chen.qiguo@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Tue, 21 Oct 2025 15:11:35 +0800
X-Zmail-TransId: 3e8168f73222009-8dcc3
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: chen.qiguo@zte.com.cn
From: Qiguo Chen <chen.qiguo@zte.com.cn>
To: sunyuechi@iscas.ac.cn, stanislaw.kardach@gmail.com,
 stephen@networkplumber.org
Cc: dev@dpdk.org, bruce.richardson@intel.com,
 Qiguo Chen <chen.qiguo@zte.com.cn>
Subject: [PATCH v4 0/1] Optimization Summary for RISC-V rte_memcpy
Date: Tue, 21 Oct 2025 14:56:06 +0800
Message-ID: <20251021065607.1418203-1-chen.qiguo@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020120832.1377782-2-chen.qiguo@zte.com.cn>
References: <20251020120832.1377782-2-chen.qiguo@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 59L7BXtJ005305
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: chen.qiguo@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 21 Oct 2025 15:11:53 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68F73239.000/4crNlF4M7zz6FyBr
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

Q2hhbmdlcyBpbiB2NDoNCiAgICAgMSlyZWJhc2UgY29kZSBvbmx5Lg0KDQpDaGFuZ2VzIGluIHYz
Og0KICAgICAxKUNoYW5nZSB0aXRsZSBmb3IgcGF0Y2gyLg0KICAgICAyKUFwcGx5IGNvcnJlY3Qg
cGF0Y2ggdmVyc2lvbiBmb3IgcGF0Y2gyLg0KICAgICAgIFRoYW5rcyB0byBTdW55dWVjaGkgZm9y
IHRoZSByZW1pbmRlci4NCg0KQ2hhbmdlcyBpbiB2MjoNCiAgICAgMSlNb2RpZnkgc29tZSBjb2Rl
cyBhbmQgZGVzY3JpcHRpb25zIGFjY29yZGluZyB0byBTdW55dWVjaGkncw0KICAgICBzdWdnZXN0
aW9ucy4NCiAgICAgMilSZW1vdmVkIGJlbmNobWFya19yZXBvcnQudHh0IHRvIGF2b2lkIHdhcm5p
bmdzLg0KDQpbUEFUQ0ggdjFdDQpJJ3ZlIGltcGxlbWVudGVkIG9wdGltaXphdGlvbnMgdG8gcnRl
X21lbWNweSB0YXJnZXRpbmcgUklTQy1WDQphcmNoaXRlY3R1cmVzLCBhY2hpZXZpbmcgYW4gYXZl
cmFnZSAxMCV+MTUlIHJlZHVjdGlvbiBpbiBleGVjdXRpb24gdGltZQ0KZm9yIGRhdGEgc2l6ZXMg
YmV0d2VlbiAxMjkgdG8gMTAyNCBieXRlcyggMTAyNX4xNjAwIGdhaW5zIGxpdHRsZSkuDQpUaGVz
ZSBlbmhhbmNlbWVudHMgZHJhdyBpbnNwaXJhdGlvbiBmcm9tIHg4NiBpbXBsZW1lbnRhdGlvbnMs
DQpzcGVjaWZpY2FsbHkgZm9jdXNpbmcgb246DQoxKUFsaWdubWVudCBIYW5kbGluZyBmb3IgVW5h
bGlnbmVkIFNjZW5hcmlvcw0KMilWZWN0b3IgQ29uZmlndXJhdGlvbiBUdW5pbmcNCjMpU3RyYXRl
Z2ljIFByZWZldGNoaW5nIHdpdGggemljYm9wDQoNCi0gUGF0Y2ggMTogQ292ZXIgbGV0dGVyDQot
IFBhdGNoIDI6IEJhc2UgaW1wbGVtZW50YXRpb24NCi0gUGF0Y2ggMzogQmVuY2htYXJrIHJlcG9y
dA0KDQoNClRlc3RlZCBvbiBUZXN0ZWQgb24gU0cyMDQ0IChWTEVOPTEyOCkgDQoNCg0KUWlndW8g
Q2hlbiAoMSk6DQogIGVhbC9yaXNjdjogb3B0aW1pemUgcnRlX21lbWNweSB3aXRoIHZlY3RvciBh
bmQgemljYm9wIGV4dGVuc2lvbnMNCg0KIC5tYWlsbWFwICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDEgKw0KIGNvbmZpZy9yaXNjdi9tZXNvbi5idWlsZCAgICAgICAgICAgfCAgMTQgKysN
CiBsaWIvZWFsL3Jpc2N2L2luY2x1ZGUvcnRlX21lbWNweS5oIHwgMzAzICsrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQogMyBmaWxlcyBjaGFuZ2VkLCAzMTYgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCg0KLS0gDQoyLjIxLjAud2luZG93cy4x


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Q2hhbmdlcyZuYnNwO2luJm5ic3A7djQ6PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7MSlyZWJhc2UmbmJzcDtjb2RlJm5ic3A7b25seS48YnIgLz4NPGJyIC8+Q2hhbmdlcyZuYnNw
O2luJm5ic3A7djM6PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7MSlDaGFuZ2Um
bmJzcDt0aXRsZSZuYnNwO2ZvciZuYnNwO3BhdGNoMi48YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsyKUFwcGx5Jm5ic3A7Y29ycmVjdCZuYnNwO3BhdGNoJm5ic3A7dmVyc2lvbiZu
YnNwO2ZvciZuYnNwO3BhdGNoMi48YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDtUaGFua3MmbmJzcDt0byZuYnNwO1N1bnl1ZWNoaSZuYnNwO2ZvciZuYnNwO3Ro
ZSZuYnNwO3JlbWluZGVyLjxiciAvPg08YnIgLz5DaGFuZ2VzJm5ic3A7aW4mbmJzcDt2Mjo8YnIg
Lz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsxKU1vZGlmeSZuYnNwO3NvbWUmbmJzcDtj
b2RlcyZuYnNwO2FuZCZuYnNwO2Rlc2NyaXB0aW9ucyZuYnNwO2FjY29yZGluZyZuYnNwO3RvJm5i
c3A7U3VueXVlY2hpJmFwb3M7czxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3N1
Z2dlc3Rpb25zLjxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzIpUmVtb3ZlZCZu
YnNwO2JlbmNobWFya19yZXBvcnQudHh0Jm5ic3A7dG8mbmJzcDthdm9pZCZuYnNwO3dhcm5pbmdz
LjxiciAvPg08YnIgLz5bUEFUQ0gmbmJzcDt2MV08YnIgLz5JJmFwb3M7dmUmbmJzcDtpbXBsZW1l
bnRlZCZuYnNwO29wdGltaXphdGlvbnMmbmJzcDt0byZuYnNwO3J0ZV9tZW1jcHkmbmJzcDt0YXJn
ZXRpbmcmbmJzcDtSSVNDLVY8YnIgLz5hcmNoaXRlY3R1cmVzLCZuYnNwO2FjaGlldmluZyZuYnNw
O2FuJm5ic3A7YXZlcmFnZSZuYnNwOzEwJX4xNSUmbmJzcDtyZWR1Y3Rpb24mbmJzcDtpbiZuYnNw
O2V4ZWN1dGlvbiZuYnNwO3RpbWU8YnIgLz5mb3ImbmJzcDtkYXRhJm5ic3A7c2l6ZXMmbmJzcDti
ZXR3ZWVuJm5ic3A7MTI5Jm5ic3A7dG8mbmJzcDsxMDI0Jm5ic3A7Ynl0ZXMoJm5ic3A7MTAyNX4x
NjAwJm5ic3A7Z2FpbnMmbmJzcDtsaXR0bGUpLjxiciAvPlRoZXNlJm5ic3A7ZW5oYW5jZW1lbnRz
Jm5ic3A7ZHJhdyZuYnNwO2luc3BpcmF0aW9uJm5ic3A7ZnJvbSZuYnNwO3g4NiZuYnNwO2ltcGxl
bWVudGF0aW9ucyw8YnIgLz5zcGVjaWZpY2FsbHkmbmJzcDtmb2N1c2luZyZuYnNwO29uOjxiciAv
PjEpQWxpZ25tZW50Jm5ic3A7SGFuZGxpbmcmbmJzcDtmb3ImbmJzcDtVbmFsaWduZWQmbmJzcDtT
Y2VuYXJpb3M8YnIgLz4yKVZlY3RvciZuYnNwO0NvbmZpZ3VyYXRpb24mbmJzcDtUdW5pbmc8YnIg
Lz4zKVN0cmF0ZWdpYyZuYnNwO1ByZWZldGNoaW5nJm5ic3A7d2l0aCZuYnNwO3ppY2JvcDxiciAv
Pg08YnIgLz4tJm5ic3A7UGF0Y2gmbmJzcDsxOiZuYnNwO0NvdmVyJm5ic3A7bGV0dGVyPGJyIC8+
LSZuYnNwO1BhdGNoJm5ic3A7MjombmJzcDtCYXNlJm5ic3A7aW1wbGVtZW50YXRpb248YnIgLz4t
Jm5ic3A7UGF0Y2gmbmJzcDszOiZuYnNwO0JlbmNobWFyayZuYnNwO3JlcG9ydDxiciAvPg08YnIg
Lz4NPGJyIC8+VGVzdGVkJm5ic3A7b24mbmJzcDtUZXN0ZWQmbmJzcDtvbiZuYnNwO1NHMjA0NCZu
YnNwOyhWTEVOPTEyOCkmbmJzcDsNPGJyIC8+DTxiciAvPg08YnIgLz5RaWd1byZuYnNwO0NoZW4m
bmJzcDsoMSk6PGJyIC8+Jm5ic3A7Jm5ic3A7ZWFsL3Jpc2N2OiZuYnNwO29wdGltaXplJm5ic3A7
cnRlX21lbWNweSZuYnNwO3dpdGgmbmJzcDt2ZWN0b3ImbmJzcDthbmQmbmJzcDt6aWNib3AmbmJz
cDtleHRlbnNpb25zPGJyIC8+DTxiciAvPiZuYnNwOy5tYWlsbWFwJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzEmbmJzcDsr
PGJyIC8+Jm5ic3A7Y29uZmlnL3Jpc2N2L21lc29uLmJ1aWxkJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNw
OzE0Jm5ic3A7Kys8YnIgLz4mbmJzcDtsaWIvZWFsL3Jpc2N2L2luY2x1ZGUvcnRlX21lbWNweS5o
Jm5ic3A7fCZuYnNwOzMwMyZuYnNwOysrKysrKysrKysrKysrKysrKysrKysrKysrKystPGJyIC8+
Jm5ic3A7MyZuYnNwO2ZpbGVzJm5ic3A7Y2hhbmdlZCwmbmJzcDszMTYmbmJzcDtpbnNlcnRpb25z
KCspLCZuYnNwOzImbmJzcDtkZWxldGlvbnMoLSk8YnIgLz4NPGJyIC8+LS0mbmJzcDsNPGJyIC8+
Mi4yMS4wLndpbmRvd3MuMTxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

