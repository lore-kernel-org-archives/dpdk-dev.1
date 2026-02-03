Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D468E8305B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 07:41:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 030264042E;
	Tue,  3 Feb 2026 08:41:47 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 9146D402A2
 for <dev@dpdk.org>; Tue,  3 Feb 2026 08:41:45 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4f4wRD1TS3z8Xs77;
 Tue, 03 Feb 2026 15:41:44 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl1.zte.com.cn with SMTP id 6137fMS4038995;
 Tue, 3 Feb 2026 15:41:22 +0800 (+08)
 (envelope-from zhang.tianhao2@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Tue, 3 Feb 2026 15:41:25 +0800
X-Zmail-TransId: 3e816981a696001-42e61
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: zhang.tianhao2@zte.com.cn
From: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Subject: [PATCH v3 0/2] net/zxdh: fix npsdk bug
Date: Tue,  3 Feb 2026 15:17:27 +0800
Message-ID: <20260203071732.2601630-1-zhang.tianhao2@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230081127.813605-2-zhang.tianhao2@zte.com.cn>
References: <20251230081127.813605-2-zhang.tianhao2@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 6137fMS4038995
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.tianhao2@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 03 Feb 2026 15:41:44 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6981A6B8.001/4f4wRD1TS3z8Xs77
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

VjM6DQogIC0gRml4IHRoZSBpbmRlbnRhdGlvbiBpc3N1ZXPjgIINCg0KVjI6DQogIC0gUmVzb2x2
ZSBjb2RlIHN0eWxlLg0KICAtIFByb3ZpZGUgY2xlYXIgZXJyb3IgbWVzc2FnZXMuDQoNClYxOg0K
ICAtIEFkZCBuZXcgdGltZW91dCBlcnJvciByZXR1cm4uDQogIC0gQWRkIFBDSWUgbGluayBoZWFs
dGggY2hlY2suDQogIC0gUmVtb3ZlIHRoZSBOUCBzb2Z0d2FyZSByZXNvdXJjZSB1bmluc3RhbGxh
dGlvbiBwcm9jZWR1cmUgZnJvbSB0aGUgTlAgb25saW5lIHVuaW5pdCBwcm9jZXNzLiANCiAgLSBO
UCBzb2Z0d2FyZSByZXNvdXJjZSB1bmluc3RhbGxhdGlvbiBzaG91bGQgYmUgY2FsbGVkIHNlcGFy
YXRlbHkgd2l0aGluIE5QIHVuaW5pdCB0byBhdm9pZCBkdXBsaWNhdGUgcmVzb3VyY2UgcmVsZWFz
ZS4NCg0KKioqIEJMVVJCIEhFUkUgKioqDQoNClRpYW5oYW8gWmhhbmcgKDIpOg0KICBuZXQvenhk
aDogYWRkIHBjaWUgYmFyIGNoYW5uZWwgY2hlY2sNCiAgbmV0L3p4ZGg6IG9wdGltaXplIHRoZSBw
cm9jZWR1cmUgZm9yIE5QIG9ubGluZSB1bmluaXQNCg0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9u
cC5jIHwgMTIgKysrKysrKy0tLS0tDQogZHJpdmVycy9uZXQvenhkaC96eGRoX25wLmggfCAgMyAr
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoN
Ci0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjM6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO0ZpeCZuYnNwO3RoZSZuYnNwO2luZGVudGF0aW9u
Jm5ic3A7aXNzdWVz44CCPGJyIC8+DTxiciAvPlYyOjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtS
ZXNvbHZlJm5ic3A7Y29kZSZuYnNwO3N0eWxlLjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtQcm92
aWRlJm5ic3A7Y2xlYXImbmJzcDtlcnJvciZuYnNwO21lc3NhZ2VzLjxiciAvPg08YnIgLz5WMTo8
YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7QWRkJm5ic3A7bmV3Jm5ic3A7dGltZW91dCZuYnNwO2Vy
cm9yJm5ic3A7cmV0dXJuLjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtBZGQmbmJzcDtQQ0llJm5i
c3A7bGluayZuYnNwO2hlYWx0aCZuYnNwO2NoZWNrLjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtS
ZW1vdmUmbmJzcDt0aGUmbmJzcDtOUCZuYnNwO3NvZnR3YXJlJm5ic3A7cmVzb3VyY2UmbmJzcDt1
bmluc3RhbGxhdGlvbiZuYnNwO3Byb2NlZHVyZSZuYnNwO2Zyb20mbmJzcDt0aGUmbmJzcDtOUCZu
YnNwO29ubGluZSZuYnNwO3VuaW5pdCZuYnNwO3Byb2Nlc3MuJm5ic3A7DTxiciAvPiZuYnNwOyZu
YnNwOy0mbmJzcDtOUCZuYnNwO3NvZnR3YXJlJm5ic3A7cmVzb3VyY2UmbmJzcDt1bmluc3RhbGxh
dGlvbiZuYnNwO3Nob3VsZCZuYnNwO2JlJm5ic3A7Y2FsbGVkJm5ic3A7c2VwYXJhdGVseSZuYnNw
O3dpdGhpbiZuYnNwO05QJm5ic3A7dW5pbml0Jm5ic3A7dG8mbmJzcDthdm9pZCZuYnNwO2R1cGxp
Y2F0ZSZuYnNwO3Jlc291cmNlJm5ic3A7cmVsZWFzZS48YnIgLz4NPGJyIC8+KioqJm5ic3A7QkxV
UkImbmJzcDtIRVJFJm5ic3A7KioqPGJyIC8+DTxiciAvPlRpYW5oYW8mbmJzcDtaaGFuZyZuYnNw
OygyKTo8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDthZGQmbmJzcDtwY2llJm5ic3A7
YmFyJm5ic3A7Y2hhbm5lbCZuYnNwO2NoZWNrPGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5i
c3A7b3B0aW1pemUmbmJzcDt0aGUmbmJzcDtwcm9jZWR1cmUmbmJzcDtmb3ImbmJzcDtOUCZuYnNw
O29ubGluZSZuYnNwO3VuaW5pdDxiciAvPg08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4
ZGhfbnAuYyZuYnNwO3wmbmJzcDsxMiZuYnNwOysrKysrKystLS0tLTxiciAvPiZuYnNwO2RyaXZl
cnMvbmV0L3p4ZGgvenhkaF9ucC5oJm5ic3A7fCZuYnNwOyZuYnNwOzMmbmJzcDsrKys8YnIgLz4m
bmJzcDsyJm5ic3A7ZmlsZXMmbmJzcDtjaGFuZ2VkLCZuYnNwOzEwJm5ic3A7aW5zZXJ0aW9ucygr
KSwmbmJzcDs1Jm5ic3A7ZGVsZXRpb25zKC0pPGJyIC8+DTxiciAvPi0tJm5ic3A7DTxiciAvPjIu
MjcuMDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

