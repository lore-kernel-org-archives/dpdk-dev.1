Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49821C44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 08:11:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 597424028B;
	Fri, 17 Jul 2026 10:11:32 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id AD9444028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:11:30 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4BE81140002B;
 Fri, 17 Jul 2026 04:11:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 17 Jul 2026 04:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784275890;
 x=1784362290; bh=a0OCpGM962QdtdkOqMFwmXlIMpYoYd0ePAIxX1HLJgU=; b=
 l9kH2KLH/feEeRRDInyF203rmtGvBhr+q6RFCGLWzTl8VPex544LWBlwrge45vAd
 sHFmrGPS+rJa6Qv2T0pGF/GtmyFSLMAVoPShdPygXjBbVdpyWijcpUChrKMNCJ2+
 ShDB9oHdYweZ5RVoRhEd7fewlZrGNuRdYoCfxADE9kmfWvrsuEBaFg9p50FRRLqR
 ywPfskYfqUAdIi/yIfliT4KHus2YS0h04x6fM+X3wHP2PDZyhQwVGCD5shmONrg5
 ofUWKuM1f+JHaZiHaXBIju4EE01gn2H2Ik9KVC3Ngo0zj+WVlxyy+P7teD9gj+4z
 SCYTCVD0D7Gsa53J/TdJmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784275890; x=
 1784362290; bh=a0OCpGM962QdtdkOqMFwmXlIMpYoYd0ePAIxX1HLJgU=; b=j
 fA7d2JAOJGVriYadpezvbe7FoRxkYkmiTEztt6QIRP2HPZW4XxvCD6W96kqqEivr
 yHC+f2zBb9uZx0mMSF4LpZ87zHPefcHBbW8Nb+q7rliIJWL/uQOrJW9/AjYrdgQS
 jLclCERSCpT+u2pOXjP/olg6GHO8NTt+tPnkiFHhFc5ukktydh2SlVw6MdCx9aJX
 IyTZx/69Fo/R+3FtlmRaFT0h4mJjKM2WKbqf2a+uJrzYU3XstAdgBt96YUU8YvgF
 AyUVvnSFDvz6nF4ceNtpoSBh+HN7dt8+z3ltwj5PmwMQrpfpe9ouS6RewWUDvk2U
 QfRhh09E8jP7eANJDj62w==
X-ME-Sender: <xms:suNZarSTiG6YHtALOCFMLHRlnlJGeIDTyZaPLhm6SS8wdvQVfmAhSQ>
 <xme:suNZahGHYqSgfwMZKbo2CFz8Gc_y7imSuUE6dKD0pBvElVA81xlDentc1pLo68u4m
 9cNdQCVjkQJ2HMs4ttnBQoFX7HZYEvIa7-I3eaclK2lJCPu6oTiYA>
X-ME-Received: <xmr:suNZav96jaAS8XskTdzCyJqJUAIRVHPi-mrmzOft_Us_jVAg-WnlwiXfB2xtSEWHs2ipkEVV0sXRZ-yW2g>
X-ME-Proxy-Cause: dmFkZTGXHui2bHd7qoL0vfzCCUl2LdcEdfLJSTZ7/yxbUtSxbbVLKi1C/WXfLqiLI9NO4g
 g+23RgAb8gHvuRcsLg5O9ASRxjNIedS/2Nc2SydjlUnGnk4f9dUfEOFZeBRUqP4P3XFJhQ
 v80BLSo4rmtFj0me0AOrHECH+i9shzN7T2TwtPaKNxZKOpFQVTm5AgQu4oihG2sataBssA
 3xR5XSt8ja1CaunZFRCD+t+4hvM6v9bb/BOY7ekXSlxFivMGlFhdelsIOM7PCYlatBd4j0
 FzlNAjtuPeay0ZpkmVgRy8Txj6jzi14vzjLesBpsyDFjJCm6wE5a6Xbt640DPbWAzO5BOG
 KKhiQ54M3p7FXS8fKsu0zaA+yzvICjhKsLtg4Ylq+Q9zdvVSdz8mryq/Qb1D578b963lBh
 atzBRZX8m3pNyUGdffiwui5SCvRCaqd8EjeWsACYVbttWat2h5Dy9MQeZZ9JfpktZI81pz
 em9Y0kHmuv3aHWC7xiIi5sWun/bMacZj6zabvziOiyPDHFFEo/Kyt66KmLwmenU949Fym3
 9CT2xwWYNZ8Cj1qgcoiNKi2Q8eUV68PacC2xPKoax/Z2hNAhd5XTBYtn52LxdTBYpNebbL
 trbNmzYc5i9r7yiDVo3rXEPHA5JInjGrcsbk8/qTq89Jvz02Z7rCKRphV6CA
X-ME-Proxy: <xmx:suNZajJwpK9UYOBaqJwY2Rqjzrcz3Bx_Y1Fv4O3BJBayeAmC_2tWUA>
 <xmx:suNZaqa5ZoSviaghOwGj7Ne9k4bFe_UxCsMRpqDo9AUa7a6zJeoDWQ>
 <xmx:suNZalKzWqyZtiouaqVq0ZtGmozEjdCy_KRRe84rXj0AE_e7rt3kBQ>
 <xmx:suNZaoCBs7UnUYNvZeV-RyHoCTAIimnY99RysZMYXFmuQrYpe1esjA>
 <xmx:suNZama3gO3ki_HYUWUX1c5akcFM5SYaK9-LafRCwU7TA6XRKry1drmz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:11:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH v3 8/8] doc: add missing headers to doxy-api-index.md
Date: Fri, 17 Jul 2026 10:11:12 +0200
Message-ID: <--xEtZJ0Sj2LGPVvl3IDnQ@monjalon.net>
In-Reply-To: <20260707085048.15295-9-marat.khalili@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260707085048.15295-9-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

07/07/2026 10:50, Marat Khalili:
> Make sure all public headers are listed in `doxy-api-index.md` to be
> reachable in HTML version. Presumably each of them should contain at
> least a general file description, though this is not checked now.

I'm not sure we should add all in this index,
especially the *_trace.h which are not really interesting.


