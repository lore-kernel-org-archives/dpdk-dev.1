Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2DE606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PdpspNbA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 288144067A;
	Tue, 27 Oct 2026 15:54:33 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 4964E40613
 for <dev@dpdk.org>; Tue, 27 Oct 2026 15:54:31 +0100 (CET)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-93a40a9a01aso123953385a.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793112870; x=1793717670; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Abcn7FZhQZPKNeYCIukqnHny3oQsp5mjtEL8xaX6AOw=;
 b=PdpspNbAWCTzSx4c8Y9QphCihKib/3I6+oINXE26l+SdK520GJHWgR8D5u1nsradhw
 L3/B6GmeksDUitUp1888OoHATn+eTyC7bGqdWx9IGUGh5/G7aCeFEOGwG77bHTUi62te
 7Smfp9XE97hcT47GzSssU2yahGlWiqcPLSaK5orW/+TaqN0GCvLNJHQC9xGx3sPjIM5O
 VBoWGjimbDLgvqWCmOsYNBsfmD5wYZ57wkFzSTfxyVOgojdTzVU4lIMELUXgTqP2Blvq
 7K3LKNFE5PeVtsc4BKnkTCJA3cu5ZYpfn9uRhXo6cyJmpa2tPdXqocaJHAe5hMf73TyB
 wzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793112870; x=1793717670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Abcn7FZhQZPKNeYCIukqnHny3oQsp5mjtEL8xaX6AOw=;
 b=eN1ovOZSQalFDWgKkjqUWs+Db/ySPMJy9NIuj03vzi5Blo8Qsq0PpPfWGrzIXTz9b9
 inM8R90OmA6lL7dEBm5Viu6YtW6dB97k14PbwefsVOsRK/FbJLJXfuH30pPE+8L/Lhzf
 OqnW/uUfa558M36usNdg4lDTFS43YDAK6XL6zCY+mfPLDTDyiv5HaaUyWSXEDP2h9Mlu
 S3fEHWeavsVaAtN3zzfts52QepIeRXoMtmy7xaVuWNvcWzd+D6J58QiuCBXFvYLJ15U7
 xS2ayAEe0jt2LuI+C308TbdB9a0UW4heh4JKTcno7PaRXABXMWL2Ptym4AMVJ/Q8x2q6
 kWFg==
X-Gm-Message-State: AFq9FYIj0n9a3diXZ5iZ3gH5OEuOanFzPvNizgGyoJaO9daahjxEcvny
 73NegoJUr/bxa2WUMajhPG8zA8AuTnsdLx98jQYqphIRybeJsGKvBUnUJsvFVg==
X-Gm-Gg: AYBFou1vUuIYXMi9dovl8pqnB7UVlKijxVZJXONVPZvol5Z199eY+qMyZpDIfVa6g2b
 vcXJTbqzZAM4rCWmsSdBskESAo67kA/IZRvuPxvg7aYkJrNErTl+jLjKlzoJ2bGty/FI50xJjIb
 HNRzehxzk5Re2Fk/3ecrS74LT5gZD7Yknf1Veq2pXTMqvcupvlvKpqs2k64duCbjjb1OFZNta/l
 AABbdQErYeBIPtJ+RqRFRT1LwQWwTW2bMyiAF7W4ZMWvCXimkLMWRP9jukNKy7d9ZNyFe3vTk/Q
 CJ12ACROWrCAa/Ht3/tVAdXSdGl1vec2hGzJECWMvHC8GeR2R3S+nvxLpLiqYhbfV1UFLHQES17
 JQCnvFay5McxbL6m45KJQltKUXulnBw4W6wgpwjrbxK/6QLqO7owpHEsSoLupSCQa2f6DDgoTqe
 PuZayKpoqiV4Ggw58BTHGlroJzg+jdcMdXDud4sO/MWb0bPP/ekEZyMbS8fQFdyPwxHVyQZ1geK
 mUXiaAqPuSgOT1ili+kmmZQRgpUvERAQijWml5wJW2gMhX4ivwtoh7h/qs2wh+e/sFqcnnSNat2
 Axwcfz/Q3Q9Nz2Jj2AIoYSYnbYXK22s5dC9frruE0wnABJYcsomcRROcIC9xBw2bhQ94Rkr4NEA
 fLvn0XqvjXCn6c9kS9FbixGmohxY=
X-Received: by 2002:a05:620a:19a4:b0:93e:7156:f814 with SMTP id
 af79cd13be357-943f4a46513mr465351985a.11.1793112870156; 
 Tue, 27 Oct 2026 07:54:30 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0789b18sm996910385a.29.2026.10.27.07.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:54:29 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v2 3/5] fib6: fix full table overwrite on address wraparound
Date: Tue, 27 Oct 2026 10:54:03 -0400
Message-Id: <20261027145405.3454251-4-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027145405.3454251-1-rsanford2@gmail.com>
References: <20261027001423.3028072-1-rsanford2@gmail.com>
 <20261027145405.3454251-1-rsanford2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

When a prefix whose range ends at the top of the address space
(ffff:ffff:...:ffff) is added, deleted, or has its next hop changed,
modify_dp() walks the more-specific routes under it and installs the
next hop into the gaps. If the last of those routes starts exactly at
the current left edge and ends at the top of the address space, the
equal-edges branch advances ledge past it with get_nxt_net(), and
ledge wraps to ::. That branch has no wraparound check, so the loop
continues. With no more routes, the final branch computes redge,
which also wraps to ::. Its exception for an unspecified ledge, which
exists for a default route added as the first route, lets the call
through, and install_to_dp() with both edges at :: overwrites the
entire table. The call returns 0, so the corruption is silent.

For example, with ::/0, ::/1 and 8000::/1 installed, deleting ::/0
makes every lookup miss. With 2001:db8::/32 and two /121 routes at
ffff:...:ff00 and ffff:...:ff80 installed, adding their covering /120
makes every address, including 2001:db8::1, return the /120's next
hop.

The same commit added a wraparound check to the other branch only.
Add the same check to the equal-edges branch.

Fixes: fd66617c5774 ("fib6: fix adding default route as first route")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 lib/fib/trie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 187360d1c8..59f043ce0e 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -506,6 +506,12 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 			rte_rib6_get_ip(tmp, &redge);
 			if (rte_ipv6_addr_eq(&ledge, &redge)) {
 				get_nxt_net(&ledge, tmp_depth);
+				/*
+				 * we got to the end of address space
+				 * and wrapped around
+				 */
+				if (rte_ipv6_addr_is_unspec(&ledge))
+					break;
 				continue;
 			}
 			ret = install_to_dp(dp, &ledge, &redge, next_hop);
-- 
2.34.1

