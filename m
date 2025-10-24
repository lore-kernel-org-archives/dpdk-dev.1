Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAD6CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 07:43:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3057940276;
	Fri, 24 Oct 2025 09:43:47 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 85A7B40267
 for <dev@dpdk.org>; Fri, 24 Oct 2025 09:43:45 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ctFJZ6lzKz8Xs6v;
 Fri, 24 Oct 2025 15:43:42 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
 by mse-fl1.zte.com.cn with SMTP id 59O7hFxF033509;
 Fri, 24 Oct 2025 15:43:15 +0800 (+08)
 (envelope-from chen.qiguo@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Fri, 24 Oct 2025 15:43:17 +0800
X-Zmail-TransId: 3e8168fb2e10009-c9230
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: chen.qiguo@zte.com.cn
From: Qiguo Chen <chen.qiguo@zte.com.cn>
To: sunyuechi@iscas.ac.cn, stanislaw.kardach@gmail.com,
 stephen@networkplumber.org
Cc: dev@dpdk.org, bruce.richardson@intel.com,
 Qiguo Chen <chen.qiguo@zte.com.cn>
Subject: [PATCH v6 0/1] Optimization Summary for RISC-V rte_memcpy 
Date: Fri, 24 Oct 2025 15:27:33 +0800
Message-ID: <20251024072734.1573077-1-chen.qiguo@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251024054128.1569133-2-chen.qiguo@zte.com.cn>
References: <20251024054128.1569133-2-chen.qiguo@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 59O7hFxF033509
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: chen.qiguo@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 24 Oct 2025 15:43:43 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68FB2E2E.000/4ctFJZ6lzKz8Xs6v
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

Q2hhbmdlcyBpbiB2NjoNCiAgICAgMSlzb2x2ZSAubWFpbG1hcCBjb25mbGljdC4NCg0KQ2hhbmdl
cyBpbiB2NToNCiAgICAgMSl0byB0cmlnIGNpIG9ubHkuDQoNCkNoYW5nZXMgaW4gdjQ6DQogICAg
IDEpcmViYXNlIGNvZGUgb25seS4NCg0KQ2hhbmdlcyBpbiB2MzoNCiAgICAgMSlDaGFuZ2UgdGl0
bGUgZm9yIHBhdGNoMi4NCiAgICAgMilBcHBseSBjb3JyZWN0IHBhdGNoIHZlcnNpb24gZm9yIHBh
dGNoMi4NCiAgICAgICBUaGFua3MgdG8gU3VueXVlY2hpIGZvciB0aGUgcmVtaW5kZXIuDQoNCkNo
YW5nZXMgaW4gdjI6DQogICAgIDEpTW9kaWZ5IHNvbWUgY29kZXMgYW5kIGRlc2NyaXB0aW9ucyBh
Y2NvcmRpbmcgdG8gU3VueXVlY2hpJ3MNCiAgICAgc3VnZ2VzdGlvbnMuDQogICAgIDIpUmVtb3Zl
ZCBiZW5jaG1hcmtfcmVwb3J0LnR4dCB0byBhdm9pZCB3YXJuaW5ncy4NCg0KW1BBVENIIHYxXQ0K
SSd2ZSBpbXBsZW1lbnRlZCBvcHRpbWl6YXRpb25zIHRvIHJ0ZV9tZW1jcHkgdGFyZ2V0aW5nIFJJ
U0MtVg0KYXJjaGl0ZWN0dXJlcywgYWNoaWV2aW5nIGFuIGF2ZXJhZ2UgMTAlfjE1JSByZWR1Y3Rp
b24gaW4gZXhlY3V0aW9uIHRpbWUNCmZvciBkYXRhIHNpemVzIGJldHdlZW4gMTI5IHRvIDEwMjQg
Ynl0ZXMoIDEwMjV+MTYwMCBnYWlucyBsaXR0bGUpLg0KVGhlc2UgZW5oYW5jZW1lbnRzIGRyYXcg
aW5zcGlyYXRpb24gZnJvbSB4ODYgaW1wbGVtZW50YXRpb25zLA0Kc3BlY2lmaWNhbGx5IGZvY3Vz
aW5nIG9uOg0KMSlBbGlnbm1lbnQgSGFuZGxpbmcgZm9yIFVuYWxpZ25lZCBTY2VuYXJpb3MNCjIp
VmVjdG9yIENvbmZpZ3VyYXRpb24gVHVuaW5nDQozKVN0cmF0ZWdpYyBQcmVmZXRjaGluZyB3aXRo
IHppY2JvcA0KDQotIFBhdGNoIDE6IENvdmVyIGxldHRlcg0KLSBQYXRjaCAyOiBCYXNlIGltcGxl
bWVudGF0aW9uDQotIFBhdGNoIDM6IEJlbmNobWFyayByZXBvcnQNCg0KDQpUZXN0ZWQgb24gVGVz
dGVkIG9uIFNHMjA0NCAoVkxFTj0xMjgpIA0KDQpRaWd1byBDaGVuICgxKToNCiAgZWFsL3Jpc2N2
OiBvcHRpbWl6ZSBydGVfbWVtY3B5IHdpdGggdmVjdG9yIGFuZCB6aWNib3AgZXh0ZW5zaW9ucw0K
DQogLm1haWxtYXAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogY29uZmlnL3Jp
c2N2L21lc29uLmJ1aWxkICAgICAgICAgICB8ICAxNCArKw0KIGxpYi9lYWwvcmlzY3YvaW5jbHVk
ZS9ydGVfbWVtY3B5LmggfCAzMDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCiAzIGZp
bGVzIGNoYW5nZWQsIDMxNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQotLSANCjIu
MjEuMC53aW5kb3dzLjE=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Q2hhbmdlcyZuYnNwO2luJm5ic3A7djY6PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7MSlzb2x2ZSZuYnNwOy5tYWlsbWFwJm5ic3A7Y29uZmxpY3QuPGJyIC8+DTxiciAvPkNoYW5n
ZXMmbmJzcDtpbiZuYnNwO3Y1OjxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzEp
dG8mbmJzcDt0cmlnJm5ic3A7Y2kmbmJzcDtvbmx5LjxiciAvPg08YnIgLz5DaGFuZ2VzJm5ic3A7
aW4mbmJzcDt2NDo8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsxKXJlYmFzZSZu
YnNwO2NvZGUmbmJzcDtvbmx5LjxiciAvPg08YnIgLz5DaGFuZ2VzJm5ic3A7aW4mbmJzcDt2Mzo8
YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsxKUNoYW5nZSZuYnNwO3RpdGxlJm5i
c3A7Zm9yJm5ic3A7cGF0Y2gyLjxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzIp
QXBwbHkmbmJzcDtjb3JyZWN0Jm5ic3A7cGF0Y2gmbmJzcDt2ZXJzaW9uJm5ic3A7Zm9yJm5ic3A7
cGF0Y2gyLjxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO1Ro
YW5rcyZuYnNwO3RvJm5ic3A7U3VueXVlY2hpJm5ic3A7Zm9yJm5ic3A7dGhlJm5ic3A7cmVtaW5k
ZXIuPGJyIC8+DTxiciAvPkNoYW5nZXMmbmJzcDtpbiZuYnNwO3YyOjxiciAvPiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOzEpTW9kaWZ5Jm5ic3A7c29tZSZuYnNwO2NvZGVzJm5ic3A7YW5k
Jm5ic3A7ZGVzY3JpcHRpb25zJm5ic3A7YWNjb3JkaW5nJm5ic3A7dG8mbmJzcDtTdW55dWVjaGkm
YXBvcztzPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7c3VnZ2VzdGlvbnMuPGJy
IC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7MilSZW1vdmVkJm5ic3A7YmVuY2htYXJr
X3JlcG9ydC50eHQmbmJzcDt0byZuYnNwO2F2b2lkJm5ic3A7d2FybmluZ3MuPGJyIC8+DTxiciAv
PltQQVRDSCZuYnNwO3YxXTxiciAvPkkmYXBvczt2ZSZuYnNwO2ltcGxlbWVudGVkJm5ic3A7b3B0
aW1pemF0aW9ucyZuYnNwO3RvJm5ic3A7cnRlX21lbWNweSZuYnNwO3RhcmdldGluZyZuYnNwO1JJ
U0MtVjxiciAvPmFyY2hpdGVjdHVyZXMsJm5ic3A7YWNoaWV2aW5nJm5ic3A7YW4mbmJzcDthdmVy
YWdlJm5ic3A7MTAlfjE1JSZuYnNwO3JlZHVjdGlvbiZuYnNwO2luJm5ic3A7ZXhlY3V0aW9uJm5i
c3A7dGltZTxiciAvPmZvciZuYnNwO2RhdGEmbmJzcDtzaXplcyZuYnNwO2JldHdlZW4mbmJzcDsx
MjkmbmJzcDt0byZuYnNwOzEwMjQmbmJzcDtieXRlcygmbmJzcDsxMDI1fjE2MDAmbmJzcDtnYWlu
cyZuYnNwO2xpdHRsZSkuPGJyIC8+VGhlc2UmbmJzcDtlbmhhbmNlbWVudHMmbmJzcDtkcmF3Jm5i
c3A7aW5zcGlyYXRpb24mbmJzcDtmcm9tJm5ic3A7eDg2Jm5ic3A7aW1wbGVtZW50YXRpb25zLDxi
ciAvPnNwZWNpZmljYWxseSZuYnNwO2ZvY3VzaW5nJm5ic3A7b246PGJyIC8+MSlBbGlnbm1lbnQm
bmJzcDtIYW5kbGluZyZuYnNwO2ZvciZuYnNwO1VuYWxpZ25lZCZuYnNwO1NjZW5hcmlvczxiciAv
PjIpVmVjdG9yJm5ic3A7Q29uZmlndXJhdGlvbiZuYnNwO1R1bmluZzxiciAvPjMpU3RyYXRlZ2lj
Jm5ic3A7UHJlZmV0Y2hpbmcmbmJzcDt3aXRoJm5ic3A7emljYm9wPGJyIC8+DTxiciAvPi0mbmJz
cDtQYXRjaCZuYnNwOzE6Jm5ic3A7Q292ZXImbmJzcDtsZXR0ZXI8YnIgLz4tJm5ic3A7UGF0Y2gm
bmJzcDsyOiZuYnNwO0Jhc2UmbmJzcDtpbXBsZW1lbnRhdGlvbjxiciAvPi0mbmJzcDtQYXRjaCZu
YnNwOzM6Jm5ic3A7QmVuY2htYXJrJm5ic3A7cmVwb3J0PGJyIC8+DTxiciAvPg08YnIgLz5UZXN0
ZWQmbmJzcDtvbiZuYnNwO1Rlc3RlZCZuYnNwO29uJm5ic3A7U0cyMDQ0Jm5ic3A7KFZMRU49MTI4
KSZuYnNwOw08YnIgLz4NPGJyIC8+UWlndW8mbmJzcDtDaGVuJm5ic3A7KDEpOjxiciAvPiZuYnNw
OyZuYnNwO2VhbC9yaXNjdjombmJzcDtvcHRpbWl6ZSZuYnNwO3J0ZV9tZW1jcHkmbmJzcDt3aXRo
Jm5ic3A7dmVjdG9yJm5ic3A7YW5kJm5ic3A7emljYm9wJm5ic3A7ZXh0ZW5zaW9uczxiciAvPg08
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

