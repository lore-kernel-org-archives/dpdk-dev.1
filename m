Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF99C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:48:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2446402AE;
	Fri, 27 Jun 2025 17:48:46 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mails.dpdk.org (Postfix) with ESMTP id D7CBE400D5;
 Fri, 27 Jun 2025 17:48:44 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so1839651f8f.1; 
 Fri, 27 Jun 2025 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751039324; x=1751644124; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkjX6yMxGbfi9++yA4GShoplQ0NIR+9GQV0wvJn3yHc=;
 b=ZrwADKp2EFvi8qo4GsJtoGxGBI8yfy34yv6iv8JYLMwV/hZS6aOS0GLY84IdbpQyRP
 DcMY51/oWOV2hp35+pEZeOXwy4vl8US3Q1oXhO03BQmzf4L0utmrJo9rm0oZXf8gB8h2
 Tc0ruJ623YjlbdT0viKJvH7+1dk8MyPMf4OZsU3MuXTPRthu89ztZlGQvWcXKcfMUh6R
 VPfYztPMw3R4xDyRCHRaIGEkVv1SY6CzKqvcxdGcA3YDsK3KNXoI8GNrLjKzpC3fu1T3
 AYpmvAQyw86/PhoNO0FBSbNN6KML5HhgrGQfPDtXJiPaLXNwxcp18meBbb1IKdiyLkWy
 586Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751039324; x=1751644124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lkjX6yMxGbfi9++yA4GShoplQ0NIR+9GQV0wvJn3yHc=;
 b=qVDO5fhvqMLTGRpP8dwbq7bnlfSjmPlL7+cn/A5HLQEy1wb2HtxAMuBhT3sr2qE2XY
 EiP3H2Z/YP9w7famnm3S8kjuaMPP+RkZy/wXANM3rLf4JoYN1Hs//G7iq0NH7slnJGFm
 ivloXmO2BsiBUCNFSJ9JHxdRGgzSWOkGaqK+rFnFgPax0Yr5+WdBbnMsRh188LgPmQTH
 FCKhrnMh/UxMtEu+0qlW1BYlzQdXw/57A0FGwwmNhAwWiyBt2tCqLF1Am8h53KVQWO3P
 Vfk7VBGzBEf8E+7XKzyeM3yhwBngORprxpGEZhlmO8PQ0S4IbcZXxOQrnVWECqWXR0vU
 szCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzrBvuacoXIJ5nPFLWclUUgqUQiZuN1ISzrURhGR5DzH+1d8vWBd5tndLSa4oZ3t4pJOP3/Bw=@dpdk.org
X-Gm-Message-State: AOJu0YzT7eQoJTZJNgkZT6ivRDxKIAa02nl+nvIibFQyluxkDMVQ8rFi
 FmZB1VxIfHuvi9PG6YqFakHDS2rPcv5HEoa/lrO+TOT5CM5fqNUyScvcOOBuECljrHUr060dsGT
 9PqAwejZb7exMv1yJqjiyvKnb5ibJY78=
X-Gm-Gg: ASbGncv8ilZqdBckQGAb79YKheBjVOo9tmvqdq4vs9I3iiTUOAevLgOsNcBEjYeGJpU
 07f/o0gEJ4jcHta0LU8ct5I/KguYli3TTJbiC0Xny1o/+TTgXIHo9DGvUUZ8kk/lUd4iL/qaoyQ
 NCJf5/pEDOVHkU6wKW6h+hU7W6t0shEwq7Hb9iVEtJV7f0QxmmcUAhKWw=
X-Google-Smtp-Source: AGHT+IHnBmjgRLn2pduMIVQiM+R0v75endATM8x/RC/P3EeoRtTMnu4cgpClMkm53xFHbMQCJ4DnZ1kk5ghSPpkkUiA=
X-Received: by 2002:a5d:58d5:0:b0:3a5:8cc2:10aa with SMTP id
 ffacd0b85a97d-3a917603a95mr2958484f8f.32.1751039324146; Fri, 27 Jun 2025
 08:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250624111253.2074168-1-edvard.fagerholm@gmail.com>
 <20250624195810.2350988-1-edvard.fagerholm@gmail.com>
 <5036333.A7TYtsqqnE@thomas>
In-Reply-To: <5036333.A7TYtsqqnE@thomas>
From: Edvard Fagerholm <edvard.fagerholm@gmail.com>
Date: Fri, 27 Jun 2025 18:48:32 +0300
X-Gm-Features: Ac12FXxJAstWfD_jUL044nZ8jRFcx-4pQRCR0I-UM9jnFuJt0lsqlnG8yimjML8
Message-ID: <CAMF0iZ5OY9xL1YF1nt8Sd25Z8ghpYZo2cmbJnM6QipTU-+6-Zg@mail.gmail.com>
Subject: Re: [PATCH v2] cpp: Fix missing extern "C" closing bracket
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 27, 2025 at 6:16=E2=80=AFPM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:
>
> 24/06/2025 21:58, Edvard Fagerholm:
> > RTE_FORCE_INTRINSICS with a C++ compiler causes rte_atomic.h and
> > rte_byteorder.h to emit on x86 an extern "C" without a closing
> > brace.
> >
> > Signed-off-by: Edvard Fagerholm <edvard.fagerholm@gmail.com>
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
> Added root cause tracking:
> Fixes: 719834a6849e ("use C linkage where appropriate in headers")
> Cc: stable@dpdk.org
>
> And changed the #endif comments to show the #ifndef condition is negative
> with an exclamation mark:
> #endif /* !RTE_FORCE_INTRINSICS */
>
> Applied, thanks and welcome!
>
> PS: I see you used AI to code your DPDK app, that's interesting
> and we will probably look to improve such tools in a near future.
>
> PS2: Thanks for the mobile games ;)
>

LLMs do manage to create the scaffolding for a DPDK application quite
well. Basically, NIC setup with different hardware accelerations is
quite tedious to set up for the first time together with starting
worker threads on the right cores. Since I needed to create my
application for ARM and x86 the LLM produced some clearly incorrect
patterns like turning RTE_FORCE_INTRINSICS on for x86 in the generated
cmake file. Hence, why I ran into this bug in the first place...

However, they also generated very inefficient code like updating
atomic variables with stats on every packet as well as making a copy
of each packet (into a malloc'd buffer). In other words, you won't be
able to vibe code yourself into a very efficient application just yet.
I did get all the scaffolding I needed to port an existing XDP
application to DPDK in only a few days, since the XDP application's
entry point is just getting the raw buffer with the packet, modifying
it in-place and sending it back. This is basically what you get in
DPDK too.

Best,
Edvard
