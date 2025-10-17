Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0474CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 09:52:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C0E5427E2;
	Fri, 17 Oct 2025 11:52:01 +0200 (CEST)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id CBE8B402DC
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:51:58 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4cp0Tk19vzz4xNtL;
 Fri, 17 Oct 2025 17:51:54 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl1.zte.com.cn with SMTP id 59H9pTAR085101;
 Fri, 17 Oct 2025 17:51:29 +0800 (+08)
 (envelope-from chen.qiguo@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Fri, 17 Oct 2025 17:51:31 +0800
X-Zmail-TransId: 3e8168f2119a009-4aedb
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: chen.qiguo@zte.com.cn
From: Qiguo Chen <chen.qiguo@zte.com.cn>
To: sunyuechi@iscas.ac.cn, stanislaw.kardach@gmail.com,
 stephen@networkplumber.org
Cc: dev@dpdk.org, bruce.richardson@intel.com,
 Qiguo Chen <chen.qiguo@zte.com.cn>
Subject: [PATCH v2 0/1]  Optimization Summary for RISC-V rte_memcpy 
Date: Fri, 17 Oct 2025 17:36:16 +0800
Message-ID: <20251017093617.1219267-1-chen.qiguo@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016090934.1166954-2-chen.qiguo@zte.com.cn>
References: <20251016090934.1166954-2-chen.qiguo@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 59H9pTAR085101
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: chen.qiguo@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 17 Oct 2025 17:51:54 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68F211BA.000/4cp0Tk19vzz4xNtL
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

Q2hhbmdlcyBpbiB2MjoNCiAgICAgMSlNb2RpZnkgc29tZSBjb2RlcyBhbmQgZGVzY3JpcHRpb25z
IGFjY29yZGluZyB0byBTdW55dWVjaGkncyBzdWdnZXN0aW9ucy4NCiAgICAgMilSZW1vdmVkIGJl
bmNobWFya19yZXBvcnQudHh0IHRvIGF2b2lkIHdhcm5pbmdzLg0KDQpbUEFUQ0ggdjFdDQpJJ3Zl
IGltcGxlbWVudGVkIG9wdGltaXphdGlvbnMgdG8gcnRlX21lbWNweSB0YXJnZXRpbmcgUklTQy1W
IGFyY2hpdGVjdHVyZXMsDQphY2hpZXZpbmcgYW4gYXZlcmFnZSAxMCV+MTUlIHJlZHVjdGlvbiBp
biBleGVjdXRpb24gdGltZSBmb3IgZGF0YSBzaXplcyBiZXR3ZWVuDQoxMjkgdG8gMTAyNCBieXRl
cyggMTAyNX4xNjAwIGdhaW5zIGxpdHRsZSkuDQpUaGVzZSBlbmhhbmNlbWVudHMgZHJhdyBpbnNw
aXJhdGlvbiBmcm9tIHg4NiBpbXBsZW1lbnRhdGlvbnMsDQogc3BlY2lmaWNhbGx5IGZvY3VzaW5n
IG9uOg0KMSlBbGlnbm1lbnQgSGFuZGxpbmcgZm9yIFVuYWxpZ25lZCBTY2VuYXJpb3MNCjIpVmVj
dG9yIENvbmZpZ3VyYXRpb24gVHVuaW5nDQozKVN0cmF0ZWdpYyBQcmVmZXRjaGluZyB3aXRoIHpp
Y2JvcA0KDQotIFBhdGNoIDE6IENvdmVyIGxldHRlcg0KLSBQYXRjaCAyOiBCYXNlIGltcGxlbWVu
dGF0aW9uDQotIFBhdGNoIDM6IEJlbmNobWFyayByZXBvcnQNCg0KDQpUZXN0ZWQgb24gVGVzdGVk
IG9uIFNHMjA0NCAoVkxFTj0xMjgpDQoNCg0KUWlndW8gQ2hlbiAoMSk6DQogIHJpc2N2IHN1cHBv
cnQgcnRlX21lbWNweSBpbiB2ZWN0b3INCg0KIC5tYWlsbWFwICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KIGNvbmZpZy9yaXNjdi9tZXNvbi5idWlsZCAgICAgICAgICAgfCAgMTQg
KysNCiBsaWIvZWFsL3Jpc2N2L2luY2x1ZGUvcnRlX21lbWNweS5oIHwgMzEwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKystDQogMyBmaWxlcyBjaGFuZ2VkLCAzMjMgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjIxLjAud2luZG93cy4x


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Q2hhbmdlcyZuYnNwO2luJm5ic3A7djI6PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7MSlNb2RpZnkmbmJzcDtzb21lJm5ic3A7Y29kZXMmbmJzcDthbmQmbmJzcDtkZXNjcmlwdGlv
bnMmbmJzcDthY2NvcmRpbmcmbmJzcDt0byZuYnNwO1N1bnl1ZWNoaSZhcG9zO3MmbmJzcDtzdWdn
ZXN0aW9ucy48YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsyKVJlbW92ZWQmbmJz
cDtiZW5jaG1hcmtfcmVwb3J0LnR4dCZuYnNwO3RvJm5ic3A7YXZvaWQmbmJzcDt3YXJuaW5ncy48
YnIgLz4NPGJyIC8+W1BBVENIJm5ic3A7djFdPGJyIC8+SSZhcG9zO3ZlJm5ic3A7aW1wbGVtZW50
ZWQmbmJzcDtvcHRpbWl6YXRpb25zJm5ic3A7dG8mbmJzcDtydGVfbWVtY3B5Jm5ic3A7dGFyZ2V0
aW5nJm5ic3A7UklTQy1WJm5ic3A7YXJjaGl0ZWN0dXJlcyw8YnIgLz5hY2hpZXZpbmcmbmJzcDth
biZuYnNwO2F2ZXJhZ2UmbmJzcDsxMCV+MTUlJm5ic3A7cmVkdWN0aW9uJm5ic3A7aW4mbmJzcDtl
eGVjdXRpb24mbmJzcDt0aW1lJm5ic3A7Zm9yJm5ic3A7ZGF0YSZuYnNwO3NpemVzJm5ic3A7YmV0
d2VlbjxiciAvPjEyOSZuYnNwO3RvJm5ic3A7MTAyNCZuYnNwO2J5dGVzKCZuYnNwOzEwMjV+MTYw
MCZuYnNwO2dhaW5zJm5ic3A7bGl0dGxlKS48YnIgLz5UaGVzZSZuYnNwO2VuaGFuY2VtZW50cyZu
YnNwO2RyYXcmbmJzcDtpbnNwaXJhdGlvbiZuYnNwO2Zyb20mbmJzcDt4ODYmbmJzcDtpbXBsZW1l
bnRhdGlvbnMsPGJyIC8+Jm5ic3A7c3BlY2lmaWNhbGx5Jm5ic3A7Zm9jdXNpbmcmbmJzcDtvbjo8
YnIgLz4xKUFsaWdubWVudCZuYnNwO0hhbmRsaW5nJm5ic3A7Zm9yJm5ic3A7VW5hbGlnbmVkJm5i
c3A7U2NlbmFyaW9zPGJyIC8+MilWZWN0b3ImbmJzcDtDb25maWd1cmF0aW9uJm5ic3A7VHVuaW5n
PGJyIC8+MylTdHJhdGVnaWMmbmJzcDtQcmVmZXRjaGluZyZuYnNwO3dpdGgmbmJzcDt6aWNib3A8
YnIgLz4NPGJyIC8+LSZuYnNwO1BhdGNoJm5ic3A7MTombmJzcDtDb3ZlciZuYnNwO2xldHRlcjxi
ciAvPi0mbmJzcDtQYXRjaCZuYnNwOzI6Jm5ic3A7QmFzZSZuYnNwO2ltcGxlbWVudGF0aW9uPGJy
IC8+LSZuYnNwO1BhdGNoJm5ic3A7MzombmJzcDtCZW5jaG1hcmsmbmJzcDtyZXBvcnQ8YnIgLz4N
PGJyIC8+DTxiciAvPlRlc3RlZCZuYnNwO29uJm5ic3A7VGVzdGVkJm5ic3A7b24mbmJzcDtTRzIw
NDQmbmJzcDsoVkxFTj0xMjgpPGJyIC8+DTxiciAvPg08YnIgLz5RaWd1byZuYnNwO0NoZW4mbmJz
cDsoMSk6PGJyIC8+Jm5ic3A7Jm5ic3A7cmlzY3YmbmJzcDtzdXBwb3J0Jm5ic3A7cnRlX21lbWNw
eSZuYnNwO2luJm5ic3A7dmVjdG9yPGJyIC8+DTxiciAvPiZuYnNwOy5tYWlsbWFwJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNw
OzEmbmJzcDsrPGJyIC8+Jm5ic3A7Y29uZmlnL3Jpc2N2L21lc29uLmJ1aWxkJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZu
YnNwOyZuYnNwOzE0Jm5ic3A7Kys8YnIgLz4mbmJzcDtsaWIvZWFsL3Jpc2N2L2luY2x1ZGUvcnRl
X21lbWNweS5oJm5ic3A7fCZuYnNwOzMxMCZuYnNwOysrKysrKysrKysrKysrKysrKysrKysrKysr
KystPGJyIC8+Jm5ic3A7MyZuYnNwO2ZpbGVzJm5ic3A7Y2hhbmdlZCwmbmJzcDszMjMmbmJzcDtp
bnNlcnRpb25zKCspLCZuYnNwOzImbmJzcDtkZWxldGlvbnMoLSk8YnIgLz4NPGJyIC8+LS0mbmJz
cDsNPGJyIC8+Mi4yMS4wLndpbmRvd3MuMTxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

