Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5939606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=elYV7abh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1134400D7;
	Tue, 27 Oct 2026 08:49:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 02FB9400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 08:49:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793087349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eC4cSYBpOmC+RvmovU0Pk58SlsurUpWZAlaBIT8fqTA=;
 b=elYV7abhQYLvqzrDuGTE/JQOO8SYK/XyR2HpFL3ZspEolMNFEJpxTJxFg+HN3mdRqmoHfJ
 0zJSz1EKuzIBEJrx8Y0dynQAbGu+KOHuPANald2Dc82kFtf5D5Z2DJwhDlYWrlBg+5+g40
 Iyv7pOmC0ky4PUPz4w18V/7/w49gNis=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-_cCyzeLHNtWEYB-bGC8QDw-1; Tue, 27 Oct 2026 03:49:07 -0400
X-MC-Unique: _cCyzeLHNtWEYB-bGC8QDw-1
X-Mimecast-MFC-AGG-ID: _cCyzeLHNtWEYB-bGC8QDw_1793087346
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3ab42f480e1so22129991fa.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 00:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793087346; x=1793692146;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eC4cSYBpOmC+RvmovU0Pk58SlsurUpWZAlaBIT8fqTA=;
 b=QsobPDWNGjzCpQ0TgNC0L6oRpEsXWljYTk64gt0zKxDvmPmLubfjlcCcQHyQFwUh0m
 1GXhM+ZbtNN0Y118XL9EA+sG0I7rOKjaLd7teIJa14QvKPvMXjucilFx7YDwPnmizwtQ
 tCQvYJ04rhQjL+IFa62ZG9A2sCrp8I08FJ1QY6wajb89e6xzHKfsxkkmnphFRemDK8U6
 JMfbDjHgogLWtndiVjdE77BzbuSkHwJ/IX4nYRUIFxcug8M8XNNBPi+a4Fxq5d5HSnCz
 y6rpQfIvmZYaAdi0QDi8V/T1k9T67pCE+/9xrY9jRUUWc11pwACtYzUwifx80zgJLXqF
 zkHw==
X-Gm-Message-State: AFq9FYIJBNq8O1AtdC6TBWVAAjEgS23mo7g4CRZBnSyzUlTltN519Oe4
 SQqJuEfb0CW4aLutxprW9l65XeR4YiDT9Tozmu2zNSNhyIUoPQSxB3o6DuHAkNpQEVznoetcZzP
 LCUNYCBEvktm4GzvWl3DTbts6PAotcAgcXYpbjcrVdstr7p3xylX6CozWIMRPKKR0e2VQ8nlFOc
 +j0ILLGy+OFtTf+J5gu90=
X-Gm-Gg: AYBFou0P0O4C6M38wCqS7Eqk4iOpYrVbltr1cjzcvy6tXm996UBjLVAeabFKxGbTKbz
 7Ne9kfKpqIR6RM1e8wD5338UWgHm7QBWTzbvGSi9LLZ5Y3TR/QFT0EmT1pYozUUw+JMDmv6EE6n
 H4DVaAvry/WPL6kCADq4dp9JJ9IoRijpSkv2b4MBhmWDnId0z28XzHZ7x73kg7guzMLG/3Zg9PP
 VNGjhe3zXZCrTG55Xi2lsUifIcmlIeRVC7bvr8o2P+Zuh4D
X-Received: by 2002:a2e:a9a5:0:b0:3aa:ee7a:5466 with SMTP id
 38308e7fff4ca-3ac6fd3e138mr23290311fa.16.1793087346229; 
 Tue, 27 Oct 2026 00:49:06 -0700 (PDT)
X-Received: by 2002:a2e:a9a5:0:b0:3aa:ee7a:5466 with SMTP id
 38308e7fff4ca-3ac6fd3e138mr23290241fa.16.1793087345749; Tue, 27 Oct 2026
 00:49:05 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027061531.3970219-1-g.singh@nxp.com>
 <20261027063131.3979699-1-g.singh@nxp.com>
 <20261027063131.3979699-2-g.singh@nxp.com>
In-Reply-To: <20261027063131.3979699-2-g.singh@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 27 Oct 2026 08:48:53 +0100
X-Gm-Features: AclHuK-xM8eVuQgzNPN5dRIuz5mnMp7o49Jlm4f-33OatTaqVanorYiuKqFeIPM
Message-ID: <CAJFAV8x05HOZgC9V4PbQfT-2z-htEajud66KVpneX4K=qDjL_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] bus/dpaa: fix maybe-uninitialized in
 bman_release_fast
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, jun.yang@nxp.com, 
 Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Neo5I0uzyUQIgZ47xYsusd86LIkj831sjTvls0nP1Jg_1793087346
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 07:31, Gagandeep Singh <g.singh@nxp.com> wrote:
>
> From: Stephen Hemminger <stephen@networkplumber.org>
>
> The conversion loop is bounded only by num, which is not checked
> unless RTE_LIBRTE_DPAA_HWDEBUG is set. GCC on ppc64le and riscv
> therefore warns that bm_bufs[0] may be read uninitialized when
> copying the first entry into the RCR.
>
> Convert entry 0 unconditionally, as bman_release() does.

bman_release() looks wrong if called with num == 0 without debug flag.
This should be fixed (probably better in a followup patch as it does
not directly relate to the Fixes: tag).
It seems a simple fix is to not assign i variable in the first place
and remove the check on i before the for loop. Just rely on the for
loop check condition.


> Fixes: e55e2e2d0c66 ("bus/dpaa: optimize DPAA multi-entry buffer pool operations")
> Cc: jun.yang@nxp.com
>
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

This current fix lgtm though we don't have CI that ran on it because
CI tested it against main.

It should go through next-net where it can be squashed in the original commit.


-- 
David Marchand

