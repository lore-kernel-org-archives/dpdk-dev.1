Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD280CCD193
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 12:24:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EED57402C8;
	Mon, 20 Oct 2025 14:24:09 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 1C200400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 14:24:08 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cqvjy6dxlz8Xs7F;
 Mon, 20 Oct 2025 20:24:06 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
 by mse-fl1.zte.com.cn with SMTP id 59KCNshQ074100;
 Mon, 20 Oct 2025 20:23:54 +0800 (+08)
 (envelope-from chen.qiguo@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Mon, 20 Oct 2025 20:23:57 +0800
X-Zmail-TransId: 3e8168f629d7009-7f682
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: chen.qiguo@zte.com.cn
From: Qiguo Chen <chen.qiguo@zte.com.cn>
To: sunyuechi@iscas.ac.cn, stanislaw.kardach@gmail.com,
 stephen@networkplumber.org
Cc: dev@dpdk.org, bruce.richardson@intel.com,
 Qiguo Chen <chen.qiguo@zte.com.cn>
Subject: [PATCH v3 0/1] Optimization Summary for RISC-V rte_memcpy
Date: Mon, 20 Oct 2025 20:08:31 +0800
Message-ID: <20251020120832.1377782-1-chen.qiguo@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017093617.1219267-2-chen.qiguo@zte.com.cn>
References: <20251017093617.1219267-2-chen.qiguo@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 59KCNshQ074100
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: chen.qiguo@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 20 Oct 2025 20:24:06 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68F629E6.001/4cqvjy6dxlz8Xs7F
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

Q2hhbmdlcyBpbiB2MzoNCiAgICAgMSlDaGFuZ2UgdGl0bGUgZm9yIHBhdGNoMi4NCiAgICAgMilB
cHBseSBjb3JyZWN0IHBhdGNoIHZlcnNpb24gZm9yIHBhdGNoMi4NCiAgICAgICBUaGFua3MgdG8g
U3VueXVlY2hpIGZvciB0aGUgcmVtaW5kZXIuDQoNCkNoYW5nZXMgaW4gdjI6DQogICAgIDEpTW9k
aWZ5IHNvbWUgY29kZXMgYW5kIGRlc2NyaXB0aW9ucyBhY2NvcmRpbmcgdG8gU3VueXVlY2hpJ3MN
CiAgICAgc3VnZ2VzdGlvbnMuDQogICAgIDIpUmVtb3ZlZCBiZW5jaG1hcmtfcmVwb3J0LnR4dCB0
byBhdm9pZCB3YXJuaW5ncy4NCg0KW1BBVENIIHYxXQ0KSSd2ZSBpbXBsZW1lbnRlZCBvcHRpbWl6
YXRpb25zIHRvIHJ0ZV9tZW1jcHkgdGFyZ2V0aW5nIFJJU0MtVg0KYXJjaGl0ZWN0dXJlcywgYWNo
aWV2aW5nIGFuIGF2ZXJhZ2UgMTAlfjE1JSByZWR1Y3Rpb24gaW4gZXhlY3V0aW9uIHRpbWUNCmZv
ciBkYXRhIHNpemVzIGJldHdlZW4gMTI5IHRvIDEwMjQgYnl0ZXMoIDEwMjV+MTYwMCBnYWlucyBs
aXR0bGUpLg0KVGhlc2UgZW5oYW5jZW1lbnRzIGRyYXcgaW5zcGlyYXRpb24gZnJvbSB4ODYgaW1w
bGVtZW50YXRpb25zLA0Kc3BlY2lmaWNhbGx5IGZvY3VzaW5nIG9uOg0KMSlBbGlnbm1lbnQgSGFu
ZGxpbmcgZm9yIFVuYWxpZ25lZCBTY2VuYXJpb3MNCjIpVmVjdG9yIENvbmZpZ3VyYXRpb24gVHVu
aW5nDQozKVN0cmF0ZWdpYyBQcmVmZXRjaGluZyB3aXRoIHppY2JvcA0KDQotIFBhdGNoIDE6IENv
dmVyIGxldHRlcg0KLSBQYXRjaCAyOiBCYXNlIGltcGxlbWVudGF0aW9uDQotIFBhdGNoIDM6IEJl
bmNobWFyayByZXBvcnQNCg0KDQpUZXN0ZWQgb24gVGVzdGVkIG9uIFNHMjA0NCAoVkxFTj0xMjgp
DQoNClFpZ3VvIENoZW4gKDEpOg0KICBsaWIvZWFsL3Jpc2N2OiBvcHRpbWl6ZSBydGVfbWVtY3B5
IHdpdGggUklTQ1YgdmVjdG9yIGFuZCB6aWNib3ANCiAgICBleHRlbnNpb25zDQoNCiAubWFpbG1h
cCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBjb25maWcvcmlzY3YvbWVzb24u
YnVpbGQgICAgICAgICAgIHwgIDE0ICsrDQogbGliL2VhbC9yaXNjdi9pbmNsdWRlL3J0ZV9tZW1j
cHkuaCB8IDMwMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KIDMgZmlsZXMgY2hhbmdl
ZCwgMzE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yMS4wLndpbmRv
d3MuMQ==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Q2hhbmdlcyZuYnNwO2luJm5ic3A7djM6PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7MSlDaGFuZ2UmbmJzcDt0aXRsZSZuYnNwO2ZvciZuYnNwO3BhdGNoMi48YnIgLz4mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsyKUFwcGx5Jm5ic3A7Y29ycmVjdCZuYnNwO3BhdGNoJm5i
c3A7dmVyc2lvbiZuYnNwO2ZvciZuYnNwO3BhdGNoMi48YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtUaGFua3MmbmJzcDt0byZuYnNwO1N1bnl1ZWNoaSZuYnNw
O2ZvciZuYnNwO3RoZSZuYnNwO3JlbWluZGVyLjxiciAvPg08YnIgLz5DaGFuZ2VzJm5ic3A7aW4m
bmJzcDt2Mjo8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsxKU1vZGlmeSZuYnNw
O3NvbWUmbmJzcDtjb2RlcyZuYnNwO2FuZCZuYnNwO2Rlc2NyaXB0aW9ucyZuYnNwO2FjY29yZGlu
ZyZuYnNwO3RvJm5ic3A7U3VueXVlY2hpJmFwb3M7czxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO3N1Z2dlc3Rpb25zLjxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OzIpUmVtb3ZlZCZuYnNwO2JlbmNobWFya19yZXBvcnQudHh0Jm5ic3A7dG8mbmJzcDthdm9pZCZu
YnNwO3dhcm5pbmdzLjxiciAvPg08YnIgLz5bUEFUQ0gmbmJzcDt2MV08YnIgLz5JJmFwb3M7dmUm
bmJzcDtpbXBsZW1lbnRlZCZuYnNwO29wdGltaXphdGlvbnMmbmJzcDt0byZuYnNwO3J0ZV9tZW1j
cHkmbmJzcDt0YXJnZXRpbmcmbmJzcDtSSVNDLVY8YnIgLz5hcmNoaXRlY3R1cmVzLCZuYnNwO2Fj
aGlldmluZyZuYnNwO2FuJm5ic3A7YXZlcmFnZSZuYnNwOzEwJX4xNSUmbmJzcDtyZWR1Y3Rpb24m
bmJzcDtpbiZuYnNwO2V4ZWN1dGlvbiZuYnNwO3RpbWU8YnIgLz5mb3ImbmJzcDtkYXRhJm5ic3A7
c2l6ZXMmbmJzcDtiZXR3ZWVuJm5ic3A7MTI5Jm5ic3A7dG8mbmJzcDsxMDI0Jm5ic3A7Ynl0ZXMo
Jm5ic3A7MTAyNX4xNjAwJm5ic3A7Z2FpbnMmbmJzcDtsaXR0bGUpLjxiciAvPlRoZXNlJm5ic3A7
ZW5oYW5jZW1lbnRzJm5ic3A7ZHJhdyZuYnNwO2luc3BpcmF0aW9uJm5ic3A7ZnJvbSZuYnNwO3g4
NiZuYnNwO2ltcGxlbWVudGF0aW9ucyw8YnIgLz5zcGVjaWZpY2FsbHkmbmJzcDtmb2N1c2luZyZu
YnNwO29uOjxiciAvPjEpQWxpZ25tZW50Jm5ic3A7SGFuZGxpbmcmbmJzcDtmb3ImbmJzcDtVbmFs
aWduZWQmbmJzcDtTY2VuYXJpb3M8YnIgLz4yKVZlY3RvciZuYnNwO0NvbmZpZ3VyYXRpb24mbmJz
cDtUdW5pbmc8YnIgLz4zKVN0cmF0ZWdpYyZuYnNwO1ByZWZldGNoaW5nJm5ic3A7d2l0aCZuYnNw
O3ppY2JvcDxiciAvPg08YnIgLz4tJm5ic3A7UGF0Y2gmbmJzcDsxOiZuYnNwO0NvdmVyJm5ic3A7
bGV0dGVyPGJyIC8+LSZuYnNwO1BhdGNoJm5ic3A7MjombmJzcDtCYXNlJm5ic3A7aW1wbGVtZW50
YXRpb248YnIgLz4tJm5ic3A7UGF0Y2gmbmJzcDszOiZuYnNwO0JlbmNobWFyayZuYnNwO3JlcG9y
dDxiciAvPg08YnIgLz4NPGJyIC8+VGVzdGVkJm5ic3A7b24mbmJzcDtUZXN0ZWQmbmJzcDtvbiZu
YnNwO1NHMjA0NCZuYnNwOyhWTEVOPTEyOCk8YnIgLz4NPGJyIC8+UWlndW8mbmJzcDtDaGVuJm5i
c3A7KDEpOjxiciAvPiZuYnNwOyZuYnNwO2xpYi9lYWwvcmlzY3Y6Jm5ic3A7b3B0aW1pemUmbmJz
cDtydGVfbWVtY3B5Jm5ic3A7d2l0aCZuYnNwO1JJU0NWJm5ic3A7dmVjdG9yJm5ic3A7YW5kJm5i
c3A7emljYm9wPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ZXh0ZW5zaW9uczxiciAvPg08
YnIgLz4mbmJzcDsubWFpbG1hcCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsxJm5ic3A7KzxiciAvPiZuYnNwO2NvbmZpZy9y
aXNjdi9tZXNvbi5idWlsZCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsxNCZuYnNwOysrPGJyIC8+Jm5i
c3A7bGliL2VhbC9yaXNjdi9pbmNsdWRlL3J0ZV9tZW1jcHkuaCZuYnNwO3wmbmJzcDszMDMmbmJz
cDsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLTxiciAvPiZuYnNwOzMmbmJzcDtmaWxlcyZu
YnNwO2NoYW5nZWQsJm5ic3A7MzE2Jm5ic3A7aW5zZXJ0aW9ucygrKSwmbmJzcDsyJm5ic3A7ZGVs
ZXRpb25zKC0pPGJyIC8+DTxiciAvPi0tJm5ic3A7DTxiciAvPjIuMjEuMC53aW5kb3dzLjE8YnIg
Lz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

