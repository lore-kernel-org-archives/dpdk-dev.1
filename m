Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808A606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JxIADrer
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 880F240151;
	Tue, 27 Oct 2026 21:52:50 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mails.dpdk.org (Postfix) with ESMTPS id D1B5B400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 21:52:48 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3ac91ac8924so215738a91.1
 for <dev@dpdk.org>; Tue, 27 Oct 2026 13:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793134367;
 x=1793739167; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nt2bQooFmsnSJox6mokdjhNTGk7gC5fLCCN+6ciSMRU=;
 b=JxIADrerNuoYJHZuNOLbP5R6E9Pv09shiVhsVE/WWqHdqGN2vP+/S591icdUnWbC9L
 XrAewHzDnbAvnRGlXl+a+gwn+EjrI8iaawami/T0beaSp1tlHld8tGLmZNxHGqCJs16h
 QIrmK8L0uj30LGeG9WbPLX6r7c0NVpSBMz0hC9c4OmAnps8S5joRVEUxviMxnlgJqawS
 zNBODHhpesrXvvWB6XnUcjZ2gO3wWAcw9I7yyMvvw3ZA6MRH6D1GAGiOMgGE4AG8sQsd
 /U8JHIxl6UbyF0oSYyTCEkZLQaZOrb4DGQPqtE8fmXSiDIRuD8wIhsHtYs/lizPRyj6b
 qoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793134367; x=1793739167;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nt2bQooFmsnSJox6mokdjhNTGk7gC5fLCCN+6ciSMRU=;
 b=ridrER8JOJg87IkM/+puPqUfxnvhErPWZUJGJR+kmxo5WzrSz1DvoaCrFN76W2v2cH
 PgoheoBfX+Hm5qrmozC/Gs1HUfah4YNUHProMErjWqFJHGHZmcokoP2qV0MWSQbUwQiY
 tWOf2OrlbEsQpE8Q6FeN1s7E6Xfn8Ipf5hXds6MvViEKeGC6M4u500TNw5dTAPADR75W
 9Glgb2GfDa32R1qC2CKp0VKht0wqvsFJ5BsksNbVg1rWo4sv+YsXhMPBxIhMR6oxuvli
 V7y/gI+VXjqCweSWitPuiNAkrBw8hCTDd/N0OlXmm92N0Ts7sLI+oxgzgGCbRAPyzcNb
 PNVw==
X-Gm-Message-State: AFq9FYIhowaheOoACYNIK8alc9zBE/sQm0inZxSfzBHvbUuFcWNtOeXJ
 kFjk2CWW04BaHe5Y1eTU6/iB+Cmfs/56X5f5PIjAep7ZZQtyrCtOyAqxG2KF4Y+9nVQwbwvJ3y4
 Nn4yH
X-Gm-Gg: AYBFou0jA2dq0n9aFSPNjsqcbd0nCnz87WsdwLQpAJRh4DU6Q8NSk7/ri8yWqlHKK5k
 QPWDUbudflyraWSA5l8QvQDr1Sbph+Gm5LDBr4YCZCEaO8UAtxVZfcrtoTrRYfzcUm26BSU60HM
 diF6T2H3nte7sntWDfpj+MRdu+lTY56o5ajMoyIFP1wLdlTQoR43fHemuedASAqBN0xi2djNkjN
 ulNYP/OXCumd6t8XW2iI70m9uhzmVNSTUbG2dYRy7FEeGEozlC1WgkdeMM0yyJTezl9v1FuwcP3
 UNLjbDt5o1XcBfP4UiOzUP0zz17ZOVWY0adNdKBdFS67wUsnzuIU+/BcUwxLfk77YJ9EgOvEqsp
 i3wIwUrTR9xqKhvZYZpYH1zCi3dUmieUm1EA6y9Yv8v2KXd4hAhZwg3TjPlcFijyqZ8gYbDU4sX
 kPlj+QdkFF/IjTy8Bv8dz68NeboUmjSeDCYhlEb9oJajDsd+RXGDkA6/YizrPgr6Ngr6S0VSXKo
 UMY83TDij4CF6yFD3fRjEjeWct4EmcpZ8whFOOyolICXwk5KnUJC6jUeTU2MndCRzDZkUjSyP5V
 hAiKhOETM3B0CQv+ThkK/Q==
X-Received: by 2002:a17:90b:4f8e:b0:3ad:1b0b:1246 with SMTP id
 98e67ed59e1d1-3ae5814f7ffmr178582a91.32.1793134367175; 
 Tue, 27 Oct 2026 13:52:47 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae57a1609esm390734a91.2.2026.10.27.13.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 13:52:46 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:52:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net
Subject: Re: [PATCH v3 00/13] Validate multiqueue configuration in ethdev
Message-ID: <20261027135241.68182f95@phoenix.local>
In-Reply-To: <20261022174447.412638-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 19:44:27 +0200
David Marchand <david.marchand@redhat.com> wrote:

> We have various checks in drivers about Rx and Tx multiqueue
> configuration.
> This series is a followup of the VMDq cleanup, finishing the job with
> DCB and RSS, and then rejecting invalid multiqueue configuration (useful
> from an ABI point of view).
> 
> Some drivers misreported their capabilities.
> It is important drivers maintainers review carefully those changes.


Applied to next-net.
Modified the release note slight with more exact wording the AI review proposed.
