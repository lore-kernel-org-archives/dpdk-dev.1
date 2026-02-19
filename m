Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93518E9A057
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:47:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B00184042E;
	Thu, 19 Feb 2026 18:47:56 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 6007F402CA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 18:47:55 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8c70ce93afaso102026785a.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771523274;
 x=1772128074; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNEfmOXho41VC9rIE4f4bTpDsKI/XzKxIew0IOddlnU=;
 b=26yOmFZraW+a2cLWF1pcPuVXEx5+0/ruRdG8iCF46OHsm9nbi2XNwghsajkoO91ad5
 HTBRqHKEdU09nYFpBqAVu66UcX3spB+E1oh8pi1pQfLSHUR83mfW+319jPuntzWid7I/
 2eS8w8rqyMRvBG2kcGxH2HLtyFgcLdAsHnbOxkFsDff5bqvP0+O2hl+bdEQvCsrcEDVz
 Pj2RDqFWwdcUXKIZxLlxG3M+Kuc0y2me0oXeQrYGOiAXHOhMbOKP9ulog1H0NmgzsYPH
 A76hd7vdR0I6esXVRWNDQYCDDMPBieHUGWyMBZKLmivxMNaF9jVAJwflKAuutUbDa7k6
 nwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523274; x=1772128074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KNEfmOXho41VC9rIE4f4bTpDsKI/XzKxIew0IOddlnU=;
 b=rov/cih0j2K1lmkh42aOvQxPjmc5gOfpeSqfe8PbqNuN/Y2eTLzb5QstLON4WdrTYZ
 omZel+dcKuoCbDXadSVUPRmG/2ZgD4VnYmwbjjMxtVcqvgLE8qVjg/A4UacrL2bmfPtI
 +YSUtu8BaR++rvLV5RcIu16GhP9XjhEP8i8gM7QgKaBhvGdAztZGpc2e0WpdvYM9NiJF
 gmiylgDTclRPg94GtMzNYAbFWPJDEf5eYojqO41yeaVpD57Cg4SWN7sPfG/NPs+Q6/kW
 ZOk8hq2o3BY+S5ymEYQSTS+UyeZZKoJ1YdpIG2zvuupFI+ZBmjn/asmR6SN91/2rJ2FG
 dHLw==
X-Gm-Message-State: AOJu0YzcaJZdiaaWKJLFFNshfz4mNAHeoLWQo+z3cp/6BD54v31ZpyTB
 pFOUOrIYwGseUJHc89XQMNN0Ul/rgAn+EENaWJQnlRCl4fcIinvs//S7tz+3a5uahCo=
X-Gm-Gg: AZuq6aIoy0yS0ST/ML13HDzeRDywbSipRKCgGpFolGAbtJUvmMOkybjY7L451sRzatD
 HEywGndEyJmLHIMbxGx656f/+VahO4ub3ahO+hllZfP7NBQnZIsVQ2Q7okC7DGELRl8wVIAnrub
 bNPLvCy2q8NfROC5I8okTOxVmbGCIWAUe2pBRZidUDsqFgj7KWNwFn7WJTXcMuMpON9NHqOy3Sp
 P6UverQcor/2rfreBAF4SMUKaLNh04Efn1Iit0G5SaqL6mk6ql7ygUDzZQyo5e7F8onlHwTFMn1
 LgAH4UkgJu5TRo41VQUc5lOopxUfkeG8y21XzqwgrmgEoyEAf2bA9jDAX0OG5nuUDVRg3OCtRAn
 m350nS0s4t1DZg4O9eSUtiV3kuudLWkFXPbgDa6tNvzG1uCzl4w/ScQ8NDyvBhxZHWnziZ0ruc7
 lvWQo/jzgJDc1WH/LZ44Ci2HuD68+K4bey9UMgu+beeRjvPEBEmY15BR/Nkhn9YqJY
X-Received: by 2002:a05:620a:1aa1:b0:8c9:f9c1:5ed with SMTP id
 af79cd13be357-8cb740b8beamr741539785a.63.1771523274149; 
 Thu, 19 Feb 2026 09:47:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cca6fddsm212344306d6.19.2026.02.19.09.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:47:53 -0800 (PST)
Date: Thu, 19 Feb 2026 09:47:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 1/6] doc: add AGENTS.md for AI code review tools
Message-ID: <20260219094749.4e3edc6e@phoenix.local>
In-Reply-To: <f7t7bsanlme.fsf@redhat.com>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260213214107.234072-1-stephen@networkplumber.org>
 <20260213214107.234072-2-stephen@networkplumber.org>
 <f7t7bsanlme.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 18 Feb 2026 09:59:21 -0500
Aaron Conole <aconole@redhat.com> wrote:

> Much of the following sections can be written as part of checkpatch,
> which means we don't need to spend compute resources with the AI on it.
> For example, telling the AI that source files need to begin with SPDX
> identifiers, line lenghts, tag format order, tag parsing, etc.  The
> downside is that if we ask the AI to *generate* code, then it won't
> follow these rules; but when we ask AI to *review* the code, it takes
> fewer tokens to submit and we can let the AI do the thing it really
> shines at - recognizing subtle patterns, rather than stuff we can write
> a python script to do.

Well, checkpatch is slow, misses somethings and doesn't provide any
good rationale back to developer. My experience is that the cost of
AI is per-input token. And AGENTS.md is also integrated into IDE's
like Visual Studio so it will get coverage there where checkpatch
will not.

> 
> I'm approaching this from the perspective of running CI using this
> AGENTS.md file - but I might be wrong on the scope of this one, as it
> may be intended for something else (like using some IDE integrated
> extensions where that stuff can make sense to guide generation).

I was starting look at kernel review-prompts then making sure
other anti-patterns in DPDK got covered.

> 
> As for the CI reviewing part, napkin math for Anthropic API shows this
> takes up about .30c / patch (~17k tok) we would submit, and that doesn't
> include whatever the patch context is - so I think we would exhaust any
> budget dedicated to this really early (probably within a few dozen
> patches).

For any reasonable size patchset I end up splitting.
For me having more through review is higher priority than keeping cost
down (at this point).

> 
> Maybe it's possible to split up the AGENTS.md file into stuff that's
> good for review and stuff that's good for generation.  WDYT?

Yes and no. Yes it could be split, but I use it for patch and existing
code review already. This is a bigger question, what do other projects do?
Being a "trail blazer" in this area is just extra wasted effort.

