Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88390CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 05:57:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10A3E402D1;
	Fri, 24 Oct 2025 07:57:25 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 78F974025F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 07:57:23 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ctBxt2Cj6z8Xs71;
 Fri, 24 Oct 2025 13:57:22 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl2.zte.com.cn with SMTP id 59O5v8PS010915;
 Fri, 24 Oct 2025 13:57:08 +0800 (+08)
 (envelope-from chen.qiguo@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Fri, 24 Oct 2025 13:57:10 +0800
X-Zmail-TransId: 3e8168fb1531009-c69e5
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: chen.qiguo@zte.com.cn
From: Qiguo Chen <chen.qiguo@zte.com.cn>
To: sunyuechi@iscas.ac.cn, stanislaw.kardach@gmail.com,
 stephen@networkplumber.org
Cc: dev@dpdk.org, bruce.richardson@intel.com,
 Qiguo Chen <chen.qiguo@zte.com.cn>
Subject: [PATCH v5 0/1] Optimization Summary for RISC-V rte_memcpy
Date: Fri, 24 Oct 2025 13:41:27 +0800
Message-ID: <20251024054128.1569133-1-chen.qiguo@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021065607.1418203-2-chen.qiguo@zte.com.cn>
References: <20251021065607.1418203-2-chen.qiguo@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 59O5v8PS010915
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: chen.qiguo@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 24 Oct 2025 13:57:22 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68FB1542.000/4ctBxt2Cj6z8Xs71
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

Q2hhbmdlcyBpbiB2NToNCiAgICAgMSl0byB0cmlnIGNpIG9ubHkuDQoNCkNoYW5nZXMgaW4gdjQ6
DQogICAgIDEpcmViYXNlIGNvZGUgb25seS4NCg0KQ2hhbmdlcyBpbiB2MzoNCiAgICAgMSlDaGFu
Z2UgdGl0bGUgZm9yIHBhdGNoMi4NCiAgICAgMilBcHBseSBjb3JyZWN0IHBhdGNoIHZlcnNpb24g
Zm9yIHBhdGNoMi4NCiAgICAgICBUaGFua3MgdG8gU3VueXVlY2hpIGZvciB0aGUgcmVtaW5kZXIu
DQoNCkNoYW5nZXMgaW4gdjI6DQogICAgIDEpTW9kaWZ5IHNvbWUgY29kZXMgYW5kIGRlc2NyaXB0
aW9ucyBhY2NvcmRpbmcgdG8gU3VueXVlY2hpJ3MNCiAgICAgc3VnZ2VzdGlvbnMuDQogICAgIDIp
UmVtb3ZlZCBiZW5jaG1hcmtfcmVwb3J0LnR4dCB0byBhdm9pZCB3YXJuaW5ncy4NCg0KW1BBVENI
IHYxXQ0KSSd2ZSBpbXBsZW1lbnRlZCBvcHRpbWl6YXRpb25zIHRvIHJ0ZV9tZW1jcHkgdGFyZ2V0
aW5nIFJJU0MtVg0KYXJjaGl0ZWN0dXJlcywgYWNoaWV2aW5nIGFuIGF2ZXJhZ2UgMTAlfjE1JSBy
ZWR1Y3Rpb24gaW4gZXhlY3V0aW9uIHRpbWUNCmZvciBkYXRhIHNpemVzIGJldHdlZW4gMTI5IHRv
IDEwMjQgYnl0ZXMoIDEwMjV+MTYwMCBnYWlucyBsaXR0bGUpLg0KVGhlc2UgZW5oYW5jZW1lbnRz
IGRyYXcgaW5zcGlyYXRpb24gZnJvbSB4ODYgaW1wbGVtZW50YXRpb25zLA0Kc3BlY2lmaWNhbGx5
IGZvY3VzaW5nIG9uOg0KMSlBbGlnbm1lbnQgSGFuZGxpbmcgZm9yIFVuYWxpZ25lZCBTY2VuYXJp
b3MNCjIpVmVjdG9yIENvbmZpZ3VyYXRpb24gVHVuaW5nDQozKVN0cmF0ZWdpYyBQcmVmZXRjaGlu
ZyB3aXRoIHppY2JvcA0KDQotIFBhdGNoIDE6IENvdmVyIGxldHRlcg0KLSBQYXRjaCAyOiBCYXNl
IGltcGxlbWVudGF0aW9uDQotIFBhdGNoIDM6IEJlbmNobWFyayByZXBvcnQNCg0KDQpUZXN0ZWQg
b24gVGVzdGVkIG9uIFNHMjA0NCAoVkxFTj0xMjgpIA0KDQoNClFpZ3VvIENoZW4gKDEpOg0KICBl
YWwvcmlzY3Y6IG9wdGltaXplIHJ0ZV9tZW1jcHkgd2l0aCB2ZWN0b3IgYW5kIHppY2JvcCBleHRl
bnNpb25zDQoNCiAubWFpbG1hcCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBj
b25maWcvcmlzY3YvbWVzb24uYnVpbGQgICAgICAgICAgIHwgIDE0ICsrDQogbGliL2VhbC9yaXNj
di9pbmNsdWRlL3J0ZV9tZW1jcHkuaCB8IDMwMyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
LQ0KIDMgZmlsZXMgY2hhbmdlZCwgMzE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoN
Ci0tIA0KMi4yMS4wLndpbmRvd3MuMQ==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Q2hhbmdlcyZuYnNwO2luJm5ic3A7djU6PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7MSl0byZuYnNwO3RyaWcmbmJzcDtjaSZuYnNwO29ubHkuPGJyIC8+DTxiciAvPkNoYW5nZXMm
bmJzcDtpbiZuYnNwO3Y0OjxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzEpcmVi
YXNlJm5ic3A7Y29kZSZuYnNwO29ubHkuPGJyIC8+DTxiciAvPkNoYW5nZXMmbmJzcDtpbiZuYnNw
O3YzOjxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzEpQ2hhbmdlJm5ic3A7dGl0
bGUmbmJzcDtmb3ImbmJzcDtwYXRjaDIuPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7MilBcHBseSZuYnNwO2NvcnJlY3QmbmJzcDtwYXRjaCZuYnNwO3ZlcnNpb24mbmJzcDtmb3Im
bmJzcDtwYXRjaDIuPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7VGhhbmtzJm5ic3A7dG8mbmJzcDtTdW55dWVjaGkmbmJzcDtmb3ImbmJzcDt0aGUmbmJzcDty
ZW1pbmRlci48YnIgLz4NPGJyIC8+Q2hhbmdlcyZuYnNwO2luJm5ic3A7djI6PGJyIC8+Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7MSlNb2RpZnkmbmJzcDtzb21lJm5ic3A7Y29kZXMmbmJz
cDthbmQmbmJzcDtkZXNjcmlwdGlvbnMmbmJzcDthY2NvcmRpbmcmbmJzcDt0byZuYnNwO1N1bnl1
ZWNoaSZhcG9zO3M8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtzdWdnZXN0aW9u
cy48YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsyKVJlbW92ZWQmbmJzcDtiZW5j
aG1hcmtfcmVwb3J0LnR4dCZuYnNwO3RvJm5ic3A7YXZvaWQmbmJzcDt3YXJuaW5ncy48YnIgLz4N
PGJyIC8+W1BBVENIJm5ic3A7djFdPGJyIC8+SSZhcG9zO3ZlJm5ic3A7aW1wbGVtZW50ZWQmbmJz
cDtvcHRpbWl6YXRpb25zJm5ic3A7dG8mbmJzcDtydGVfbWVtY3B5Jm5ic3A7dGFyZ2V0aW5nJm5i
c3A7UklTQy1WPGJyIC8+YXJjaGl0ZWN0dXJlcywmbmJzcDthY2hpZXZpbmcmbmJzcDthbiZuYnNw
O2F2ZXJhZ2UmbmJzcDsxMCV+MTUlJm5ic3A7cmVkdWN0aW9uJm5ic3A7aW4mbmJzcDtleGVjdXRp
b24mbmJzcDt0aW1lPGJyIC8+Zm9yJm5ic3A7ZGF0YSZuYnNwO3NpemVzJm5ic3A7YmV0d2VlbiZu
YnNwOzEyOSZuYnNwO3RvJm5ic3A7MTAyNCZuYnNwO2J5dGVzKCZuYnNwOzEwMjV+MTYwMCZuYnNw
O2dhaW5zJm5ic3A7bGl0dGxlKS48YnIgLz5UaGVzZSZuYnNwO2VuaGFuY2VtZW50cyZuYnNwO2Ry
YXcmbmJzcDtpbnNwaXJhdGlvbiZuYnNwO2Zyb20mbmJzcDt4ODYmbmJzcDtpbXBsZW1lbnRhdGlv
bnMsPGJyIC8+c3BlY2lmaWNhbGx5Jm5ic3A7Zm9jdXNpbmcmbmJzcDtvbjo8YnIgLz4xKUFsaWdu
bWVudCZuYnNwO0hhbmRsaW5nJm5ic3A7Zm9yJm5ic3A7VW5hbGlnbmVkJm5ic3A7U2NlbmFyaW9z
PGJyIC8+MilWZWN0b3ImbmJzcDtDb25maWd1cmF0aW9uJm5ic3A7VHVuaW5nPGJyIC8+MylTdHJh
dGVnaWMmbmJzcDtQcmVmZXRjaGluZyZuYnNwO3dpdGgmbmJzcDt6aWNib3A8YnIgLz4NPGJyIC8+
LSZuYnNwO1BhdGNoJm5ic3A7MTombmJzcDtDb3ZlciZuYnNwO2xldHRlcjxiciAvPi0mbmJzcDtQ
YXRjaCZuYnNwOzI6Jm5ic3A7QmFzZSZuYnNwO2ltcGxlbWVudGF0aW9uPGJyIC8+LSZuYnNwO1Bh
dGNoJm5ic3A7MzombmJzcDtCZW5jaG1hcmsmbmJzcDtyZXBvcnQ8YnIgLz4NPGJyIC8+DTxiciAv
PlRlc3RlZCZuYnNwO29uJm5ic3A7VGVzdGVkJm5ic3A7b24mbmJzcDtTRzIwNDQmbmJzcDsoVkxF
Tj0xMjgpJm5ic3A7DTxiciAvPg08YnIgLz4NPGJyIC8+UWlndW8mbmJzcDtDaGVuJm5ic3A7KDEp
OjxiciAvPiZuYnNwOyZuYnNwO2VhbC9yaXNjdjombmJzcDtvcHRpbWl6ZSZuYnNwO3J0ZV9tZW1j
cHkmbmJzcDt3aXRoJm5ic3A7dmVjdG9yJm5ic3A7YW5kJm5ic3A7emljYm9wJm5ic3A7ZXh0ZW5z
aW9uczxiciAvPg08YnIgLz4mbmJzcDsubWFpbG1hcCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsxJm5ic3A7KzxiciAvPiZu
YnNwO2NvbmZpZy9yaXNjdi9tZXNvbi5idWlsZCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsxNCZuYnNw
OysrPGJyIC8+Jm5ic3A7bGliL2VhbC9yaXNjdi9pbmNsdWRlL3J0ZV9tZW1jcHkuaCZuYnNwO3wm
bmJzcDszMDMmbmJzcDsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLTxiciAvPiZuYnNwOzMm
bmJzcDtmaWxlcyZuYnNwO2NoYW5nZWQsJm5ic3A7MzE2Jm5ic3A7aW5zZXJ0aW9ucygrKSwmbmJz
cDsyJm5ic3A7ZGVsZXRpb25zKC0pPGJyIC8+DTxiciAvPi0tJm5ic3A7DTxiciAvPjIuMjEuMC53
aW5kb3dzLjE8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

