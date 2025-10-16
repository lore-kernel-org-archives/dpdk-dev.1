Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D9DCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 09:25:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9FD840E3F;
	Thu, 16 Oct 2025 11:25:13 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 3CAD540269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 11:25:12 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cnMxM3qTtz8Xs7G;
 Thu, 16 Oct 2025 17:25:11 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl2.zte.com.cn with SMTP id 59G9Ocr3042853;
 Thu, 16 Oct 2025 17:24:38 +0800 (+08)
 (envelope-from chen.qiguo@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 16 Oct 2025 17:24:40 +0800
X-Zmail-TransId: 3e8168f0b9d3009-21f12
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: chen.qiguo@zte.com.cn
From: Qiguo Chen <chen.qiguo@zte.com.cn>
To: stanislaw.kardach@gmail.com, sunyuechi@iscas.ac.cn,
 stephen@networkplumber.org
Cc: dev@dpdk.org, bruce.richardson@intel.com,
 Qiguo Chen <chen.qiguo@zte.com.cn>
Subject: [PATCH v1 0/2] Optimization Summary for RISC-V rte_memcpy
Date: Thu, 16 Oct 2025 17:09:32 +0800
Message-ID: <20251016090934.1166954-1-chen.qiguo@zte.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 59G9Ocr3042853
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: chen.qiguo@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 16 Oct 2025 17:25:11 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68F0B9F7.005/4cnMxM3qTtz8Xs7G
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

SSd2ZSBpbXBsZW1lbnRlZCBvcHRpbWl6YXRpb25zIHRvIHJ0ZV9tZW1jcHkgdGFyZ2V0aW5nIFJJ
U0MtViBhcmNoaXRlY3R1cmVzLCANCmFjaGlldmluZyBhbiBhdmVyYWdlIDEwJX4xNSUgcmVkdWN0
aW9uIGluIGV4ZWN1dGlvbiB0aW1lIGZvciBkYXRhIHNpemVzIGJldHdlZW4NCjEyOSB0byAxMDI0
IGJ5dGVzKCAxMDI1fjE2MDAgZ2FpbnMgbGl0dGxlKS4NClRoZXNlIGVuaGFuY2VtZW50cyBkcmF3
IGluc3BpcmF0aW9uIGZyb20geDg2IGltcGxlbWVudGF0aW9ucywNCiBzcGVjaWZpY2FsbHkgZm9j
dXNpbmcgb246DQoxKUFsaWdubWVudCBIYW5kbGluZyBmb3IgVW5hbGlnbmVkIFNjZW5hcmlvcw0K
MilWZWN0b3IgQ29uZmlndXJhdGlvbiBUdW5pbmcNCjMpU3RyYXRlZ2ljIFByZWZldGNoaW5nDQoN
Ci0gUGF0Y2ggMTogQ292ZXIgbGV0dGVyDQotIFBhdGNoIDI6IEJhc2UgaW1wbGVtZW50YXRpb24N
Ci0gUGF0Y2ggMzogQmVuY2htYXJrIHJlcG9ydA0KDQoNClRlc3RlZCBvbiBUZXN0ZWQgb24gU0cy
MDQ0IChWTEVOPTEyOCkNCg0KDQpRaWd1byBDaGVuICgyKToNCiAgcmlzY3Ygc3VwcG9ydCBydGVf
bWVtY3B5IGluIHZlY3Rvcg0KICBiZW5jaG1hcmsgcmVwb3J0IGZvciBydGVfbWVtY3B5DQoNCiAu
bWFpbG1hcCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBiZW5jaG1hcmtfcmVw
b3J0LnR4dCAgICAgICAgICAgICAgIHwgMTQ5ICsrKysrKysrKysrKysrDQogY29uZmlnL3Jpc2N2
L21lc29uLmJ1aWxkICAgICAgICAgICB8ICAxNCArKw0KIGxpYi9lYWwvcmlzY3YvaW5jbHVkZS9y
dGVfbWVtY3B5LmggfCAzMTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCiA0IGZpbGVz
IGNoYW5nZWQsIDQ3MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBiZW5jaG1hcmtfcmVwb3J0LnR4dA0KDQotLSANCjIuMjEuMC53aW5kb3dzLjE=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SSZhcG9zO3ZlJm5ic3A7aW1wbGVtZW50ZWQmbmJzcDtvcHRpbWl6YXRpb25zJm5ic3A7dG8mbmJz
cDtydGVfbWVtY3B5Jm5ic3A7dGFyZ2V0aW5nJm5ic3A7UklTQy1WJm5ic3A7YXJjaGl0ZWN0dXJl
cywmbmJzcDsNPGJyIC8+YWNoaWV2aW5nJm5ic3A7YW4mbmJzcDthdmVyYWdlJm5ic3A7MTAlfjE1
JSZuYnNwO3JlZHVjdGlvbiZuYnNwO2luJm5ic3A7ZXhlY3V0aW9uJm5ic3A7dGltZSZuYnNwO2Zv
ciZuYnNwO2RhdGEmbmJzcDtzaXplcyZuYnNwO2JldHdlZW48YnIgLz4xMjkmbmJzcDt0byZuYnNw
OzEwMjQmbmJzcDtieXRlcygmbmJzcDsxMDI1fjE2MDAmbmJzcDtnYWlucyZuYnNwO2xpdHRsZSku
PGJyIC8+VGhlc2UmbmJzcDtlbmhhbmNlbWVudHMmbmJzcDtkcmF3Jm5ic3A7aW5zcGlyYXRpb24m
bmJzcDtmcm9tJm5ic3A7eDg2Jm5ic3A7aW1wbGVtZW50YXRpb25zLDxiciAvPiZuYnNwO3NwZWNp
ZmljYWxseSZuYnNwO2ZvY3VzaW5nJm5ic3A7b246PGJyIC8+MSlBbGlnbm1lbnQmbmJzcDtIYW5k
bGluZyZuYnNwO2ZvciZuYnNwO1VuYWxpZ25lZCZuYnNwO1NjZW5hcmlvczxiciAvPjIpVmVjdG9y
Jm5ic3A7Q29uZmlndXJhdGlvbiZuYnNwO1R1bmluZzxiciAvPjMpU3RyYXRlZ2ljJm5ic3A7UHJl
ZmV0Y2hpbmc8YnIgLz4NPGJyIC8+LSZuYnNwO1BhdGNoJm5ic3A7MTombmJzcDtDb3ZlciZuYnNw
O2xldHRlcjxiciAvPi0mbmJzcDtQYXRjaCZuYnNwOzI6Jm5ic3A7QmFzZSZuYnNwO2ltcGxlbWVu
dGF0aW9uPGJyIC8+LSZuYnNwO1BhdGNoJm5ic3A7MzombmJzcDtCZW5jaG1hcmsmbmJzcDtyZXBv
cnQ8YnIgLz4NPGJyIC8+DTxiciAvPlRlc3RlZCZuYnNwO29uJm5ic3A7VGVzdGVkJm5ic3A7b24m
bmJzcDtTRzIwNDQmbmJzcDsoVkxFTj0xMjgpPGJyIC8+DTxiciAvPg08YnIgLz5RaWd1byZuYnNw
O0NoZW4mbmJzcDsoMik6PGJyIC8+Jm5ic3A7Jm5ic3A7cmlzY3YmbmJzcDtzdXBwb3J0Jm5ic3A7
cnRlX21lbWNweSZuYnNwO2luJm5ic3A7dmVjdG9yPGJyIC8+Jm5ic3A7Jm5ic3A7YmVuY2htYXJr
Jm5ic3A7cmVwb3J0Jm5ic3A7Zm9yJm5ic3A7cnRlX21lbWNweTxiciAvPg08YnIgLz4mbmJzcDsu
bWFpbG1hcCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wm
bmJzcDsmbmJzcDsmbmJzcDsxJm5ic3A7KzxiciAvPiZuYnNwO2JlbmNobWFya19yZXBvcnQudHh0
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOzE0OSZuYnNwOysrKysrKysr
KysrKysrPGJyIC8+Jm5ic3A7Y29uZmlnL3Jpc2N2L21lc29uLmJ1aWxkJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNw
OyZuYnNwOzE0Jm5ic3A7Kys8YnIgLz4mbmJzcDtsaWIvZWFsL3Jpc2N2L2luY2x1ZGUvcnRlX21l
bWNweS5oJm5ic3A7fCZuYnNwOzMxMCZuYnNwOysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
PGJyIC8+Jm5ic3A7NCZuYnNwO2ZpbGVzJm5ic3A7Y2hhbmdlZCwmbmJzcDs0NzImbmJzcDtpbnNl
cnRpb25zKCspLCZuYnNwOzImbmJzcDtkZWxldGlvbnMoLSk8YnIgLz4mbmJzcDtjcmVhdGUmbmJz
cDttb2RlJm5ic3A7MTAwNjQ0Jm5ic3A7YmVuY2htYXJrX3JlcG9ydC50eHQ8YnIgLz4NPGJyIC8+
LS0mbmJzcDsNPGJyIC8+Mi4yMS4wLndpbmRvd3MuMTxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

