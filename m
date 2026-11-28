Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F91606A31C
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Nov 2026 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=zS81XLDS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA67C402C1;
	Sat, 28 Nov 2026 05:17:43 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTPS id B18A1402B9
 for <dev@dpdk.org>; Sat, 28 Nov 2026 05:17:42 +0100 (CET)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jbxpC2BnSz8Xrr9;
 Sat, 28 Nov 2026 12:17:39 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
 s=z202610; t=1795839459;
 bh=euKJOVc9QsrbtNlmI7cFXi89YV7YcqFhwCmP73HCOlM=;
 h=From:To:Cc:Subject:Date;
 b=zS81XLDShaI5qb37C44Lac+iHFzT98mcT922S9PNbnxw6LjIXIAMlvFxtgXLR17NT
 FZb7mlM52Q2wTN1cv842W399aTXm3pWnaTW4jXmz8QcPt+cbT54s6rMGaJYozWoNgk
 EdPm40Iz9cmbtWuhu0trcLGEdp5Nx0Uc/wjTkOX/ciMVP9ykFOus9opaDBIFgPlntX
 yf//5uCblHeG0kvslOVnVJElaqSkH7/NPAEwK3fWbp5yArMKHMfngkyyyU9AoWoiI1
 tRdJVdHuMFiKm/hGlRjmJzPkKaB0qgK/NCN+p+vbeNO7PJWToR9PDjA6mx8H6aWD9b
 1C5CNwFma+YfA==
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl2.zte.com.cn with SMTP id 6AS4HV4a013458;
 Sat, 28 Nov 2026 12:17:31 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Sat, 28 Nov 2026 12:17:32 +0800
X-Zmail-TransId: 3e816b0a55d7032-b9d22
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>
Subject: [PATCH v1 0/2] net/zxdh: fix issues reported by GCC analyzer
Date: Sat, 28 Nov 2026 12:04:56 +0800
Message-ID: <20261128040458.3967016-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 6AS4HV4a013458
X-TLS: YES
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 28 Nov 2026 12:17:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B0A55E3.000/4jbxpC2BnSz8Xrr9
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



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

VHdvIG1lbW9yeSBzYWZldHkgaXNzdWVzIGluIHRoZSB6eGRoIGRyaXZlciwgYm90aCBmb3VuZCB3
aXRoDQpnY2MgLWZhbmFseXplcjoNCg0KLSB6eGRoX2dldF9yZXNfaW5mbygpIGNvcGllcyBhIHJl
cGx5IGxlbmd0aCB0YWtlbiBmcm9tIHRoZSBkZXZpY2UgaW50bw0KICBhIGNhbGxlciBidWZmZXIg
d2hvc2Ugc2l6ZSBpdCBpcyBub3QgdG9sZC4gQm90aCBjYWxsZXJzIHBhc3MgYQ0KICBvbmUtYnl0
ZSBvYmplY3QsIHNvIGFuIG92ZXJzaXplZCBsZW5ndGggb3ZlcndyaXRlcyB0aGVpciBzdGFjaywg
YW5kDQogIGEgbGVuZ3RoIGFib3ZlIHRoZSByZWNlaXZlIGJ1ZmZlciBzaXplIGFsc28gb3ZlcnJ1
bnMgdGhhdCBidWZmZXINCiAgKHBhdGNoIDEpLg0KLSBmZF9mbG93X3BhcnNlX3BhdHRlcm4oKSBh
bmQgZmRfZmxvd19wYXJzZV9hY3Rpb24oKSBhbGxvY2F0ZSBhIGZsb3cNCiAgZW50cnkgd2hlbiBy
dGVfZmxvd192YWxpZGF0ZSgpIHBhc3NlcyBkaF9mbG93IGFzIE5VTEwsIGFuZCBmcmVlIGl0DQog
IG9uIG9ubHkgb25lIGV4aXQsIHNvIGV2ZXJ5IHZhbGlkYXRlIGxlYWtzIG1lbW9yeSAocGF0Y2gg
MikuDQoNCkp1bmxvbmcgV2FuZyAoMik6DQogIG5ldC96eGRoOiBib3VuZCByZXNvdXJjZSB0YWJs
ZSByZXBseSBsZW5ndGggYmVmb3JlIGNvcHlpbmcNCiAgbmV0L3p4ZGg6IGF2b2lkIGxlYWtpbmcg
ZmxvdyBlbnRyeSBvbiB2YWxpZGF0aW9uDQoNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfY29tbW9u
LmMgfCAyNCArKysrKysrKysrLS0tLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmMgICB8
IDU4ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQs
IDMzIGluc2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VHdvJm5ic3A7bWVtb3J5Jm5ic3A7c2FmZXR5Jm5ic3A7aXNzdWVzJm5ic3A7aW4mbmJzcDt0aGUm
bmJzcDt6eGRoJm5ic3A7ZHJpdmVyLCZuYnNwO2JvdGgmbmJzcDtmb3VuZCZuYnNwO3dpdGg8YnIg
Lz5nY2MmbmJzcDstZmFuYWx5emVyOjxiciAvPg08YnIgLz4tJm5ic3A7enhkaF9nZXRfcmVzX2lu
Zm8oKSZuYnNwO2NvcGllcyZuYnNwO2EmbmJzcDtyZXBseSZuYnNwO2xlbmd0aCZuYnNwO3Rha2Vu
Jm5ic3A7ZnJvbSZuYnNwO3RoZSZuYnNwO2RldmljZSZuYnNwO2ludG88YnIgLz4mbmJzcDsmbmJz
cDthJm5ic3A7Y2FsbGVyJm5ic3A7YnVmZmVyJm5ic3A7d2hvc2UmbmJzcDtzaXplJm5ic3A7aXQm
bmJzcDtpcyZuYnNwO25vdCZuYnNwO3RvbGQuJm5ic3A7Qm90aCZuYnNwO2NhbGxlcnMmbmJzcDtw
YXNzJm5ic3A7YTxiciAvPiZuYnNwOyZuYnNwO29uZS1ieXRlJm5ic3A7b2JqZWN0LCZuYnNwO3Nv
Jm5ic3A7YW4mbmJzcDtvdmVyc2l6ZWQmbmJzcDtsZW5ndGgmbmJzcDtvdmVyd3JpdGVzJm5ic3A7
dGhlaXImbmJzcDtzdGFjaywmbmJzcDthbmQ8YnIgLz4mbmJzcDsmbmJzcDthJm5ic3A7bGVuZ3Ro
Jm5ic3A7YWJvdmUmbmJzcDt0aGUmbmJzcDtyZWNlaXZlJm5ic3A7YnVmZmVyJm5ic3A7c2l6ZSZu
YnNwO2Fsc28mbmJzcDtvdmVycnVucyZuYnNwO3RoYXQmbmJzcDtidWZmZXI8YnIgLz4mbmJzcDsm
bmJzcDsocGF0Y2gmbmJzcDsxKS48YnIgLz4tJm5ic3A7ZmRfZmxvd19wYXJzZV9wYXR0ZXJuKCkm
bmJzcDthbmQmbmJzcDtmZF9mbG93X3BhcnNlX2FjdGlvbigpJm5ic3A7YWxsb2NhdGUmbmJzcDth
Jm5ic3A7ZmxvdzxiciAvPiZuYnNwOyZuYnNwO2VudHJ5Jm5ic3A7d2hlbiZuYnNwO3J0ZV9mbG93
X3ZhbGlkYXRlKCkmbmJzcDtwYXNzZXMmbmJzcDtkaF9mbG93Jm5ic3A7YXMmbmJzcDtOVUxMLCZu
YnNwO2FuZCZuYnNwO2ZyZWUmbmJzcDtpdDxiciAvPiZuYnNwOyZuYnNwO29uJm5ic3A7b25seSZu
YnNwO29uZSZuYnNwO2V4aXQsJm5ic3A7c28mbmJzcDtldmVyeSZuYnNwO3ZhbGlkYXRlJm5ic3A7
bGVha3MmbmJzcDttZW1vcnkmbmJzcDsocGF0Y2gmbmJzcDsyKS48YnIgLz4NPGJyIC8+SnVubG9u
ZyZuYnNwO1dhbmcmbmJzcDsoMik6PGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7Ym91
bmQmbmJzcDtyZXNvdXJjZSZuYnNwO3RhYmxlJm5ic3A7cmVwbHkmbmJzcDtsZW5ndGgmbmJzcDti
ZWZvcmUmbmJzcDtjb3B5aW5nPGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7YXZvaWQm
bmJzcDtsZWFraW5nJm5ic3A7ZmxvdyZuYnNwO2VudHJ5Jm5ic3A7b24mbmJzcDt2YWxpZGF0aW9u
PGJyIC8+DTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9jb21tb24uYyZuYnNwO3wm
bmJzcDsyNCZuYnNwOysrKysrKysrKystLS0tPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96
eGRoX2Zsb3cuYyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDs1OCZuYnNwOysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS08YnIgLz4mbmJzcDsyJm5ic3A7ZmlsZXMmbmJzcDtjaGFuZ2Vk
LCZuYnNwOzMzJm5ic3A7aW5zZXJ0aW9ucygrKSwmbmJzcDs0OSZuYnNwO2RlbGV0aW9ucygtKTxi
ciAvPg08YnIgLz4tLSZuYnNwOw08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

