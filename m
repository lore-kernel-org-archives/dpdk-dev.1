Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2EF60A262D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=bg+lH3yt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B103040283;
	Tue, 20 Oct 2026 17:07:49 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id F187F4025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:07:48 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8a0673d9bd2so1428648b3a.3
 for <dev@dpdk.org>; Tue, 20 Oct 2026 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792508868;
 x=1793113668; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hfi0uSFElOmxUDSHb9bvyzZeWl3HGjS2JG3chXbHWRQ=;
 b=bg+lH3yt+c9nfl0PK18vYgQmhLTUh7aJclrxg3eDuLhJIwK+cd+iEuGcfTUFQn8EVQ
 BNhIAijavG4bcca5Jlw8Zc+vXb8Y+c3/fF+mjaFoMZNc2tRH7wyVAOCjV5P5unBVygYT
 iE4sXyS5SY7wKQ5kSJ3ut+FBsfnfXGxpRJfQZg/17QpSXlGnHu54Ad8e5tn2BNzItSYB
 1ZoB1F6dCdt6Lo/eF8q4Yf+pzyNKcdPwlI3o0eJUW9bnqXNwsKmk7Ok3s3IUeDMrfJyk
 xngdjOr/zbS8C6aJEGNKonrELhEUi7aB4jQa9JPlHDjR9Zrl6pBOwylfNJ8qjq2rDX8y
 qc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508868; x=1793113668;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hfi0uSFElOmxUDSHb9bvyzZeWl3HGjS2JG3chXbHWRQ=;
 b=mXY6SzJlSZfh6hBdAZb3IwAFPPjKK6hXf3DN3usc4N3EiauNfBT2phP3xUugCov3Jn
 qg0wWHuW9vmW1v8IMa2lCeij7Luf9GjJnVXIT8Lg60jgDceAtHf1rHB5i68HO//n9IvY
 K8PAJbxoHBQybekA7+3j4ndjGK/0vL1y2b7OyypCwfr2jHjQIHkUx6wKdOtgu6r83J6s
 d2pORXNFvn5+NZxCuGgyi/i2G03KPyJ5w8Pn98WJrhG+uBiCxnI4bBRpZJ19cAUpZZNt
 U8RctL2YCL6nVcBf3enuaIpWP44pJ0njm1AkvccalJM1Dgt2DtiPTJ2/4xaAjJAiHppb
 GLQQ==
X-Gm-Message-State: AFq9FYLIWzES2T+TuuT0797azlOJJwKUlwL3+YiXUFXJNrgWKGlW6Waf
 aeUltfiswwLk0eAjSDWHdNn7yRdq+KEOpbZmJbCDzxOUPpqOHqCjY/Nas1S1RkCxC1k=
X-Gm-Gg: AYBFou03EmI3GlkWyD5B8ZFxXLhZSppK856jx1vuR4cj+BFSP8b8h5RHCKutdOgZsdI
 dwMFBCzqE7kJV8pfQyH5eXdDACBBKFND+UMnApMaXeCZjmZsbtxc+plG0ef6pfWPANwLNSpwXC0
 XCNydzllh8ew/Ucp138oe7oQRNj/e5t8cX4zi8ktR7KMhvLHCuNZR+bfH1MELthoEI05gUZULkJ
 Drpvvznfth7z4Fp6x5dT9ksX0vX1VUiB7hGQRA/8T6HbL+ZcLxNQFNWSFZHhIyDNpwpJySqqNmJ
 qb0vGn9ZGmILfXt1kmQb0UG6o2RuS8o7VZLDbuHPAYtl+65SEQAfVE/YnV4bkLUAIBoe8UgR1tV
 X7Am9dkMGGFft/CWh2+fl99+wdtttF6UcDb1aJ3VNvZ5wJJOhuS0FvlE72NmJqJvh25iYSA11qk
 sIB32hFxF2I08yje3Xuo1mhXzQnkWoPaBCDzWG8m3uuj4/Gl9lGqakWrSBC+tu7h/NWaiHTDQjy
 4Gk5kY+J/mHLWw25hXqLPnEmhGGht0jOVnufV3Z
X-Received: by 2002:a05:6a21:1b85:b0:3de:4976:a0fe with SMTP id
 adf61e73a8af0-3e226113affmr9572022637.64.1792508867992; 
 Tue, 20 Oct 2026 08:07:47 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd654850c61sm5215885a12.1.2026.10.20.08.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:07:47 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:07:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v14-S2 00/10] net/dpaa2 updates
Message-ID: <20261020080745.64392a12@phoenix.local>
In-Reply-To: <20261020144841.506038-1-prashant.gupta_3@nxp.com>
References: <20261019183443.176790-1-prashant.gupta_3@nxp.com>
 <20261020144841.506038-1-prashant.gupta_3@nxp.com>
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

On Tue, 20 Oct 2026 20:18:31 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> Changes in v14:
> - Use the last Rx queue configured in each traffic class as
>   the default flow steering miss queue.
> - Update the release note accordingly.


Looks good applied to next-net
