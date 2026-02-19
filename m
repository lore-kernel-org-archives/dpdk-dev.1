Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C325E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 09:12:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B176402ED;
	Thu, 19 Feb 2026 10:12:52 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 71167402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:12:51 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-896ff127650so11930386d6.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:12:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771492371; cv=none;
 d=google.com; s=arc-20240605;
 b=FrPZxVR2bBrUZrKOdfwI0q62T/tW+4zBiGTeSepW2pbLr3A6w6kCZ+5CWhOQc068Db
 CD6pTytVCYnD6AlbxLaRUHAxYBHqGrjNRNe/oftwCZE3X6gC/zFA+lMMgzYn20kxFMOq
 N/BmprY8cXgdqgUMM1mT9INOA3SFlC5opLNF9ZfrqhPwo+TLZ2Qab9yAK7FWAeNThBNT
 bPeV/flIAE8thTPHkQuU4WRfXaJv0cMHq9YdF9e5PEqIYJpbmcqo+MAeArbzFiz8cAmb
 hRgjnL1gehqD8csvZ2kl6wDmr6RBJN57AV0uaSizxLQlAyNXigvb3CrbHMC2gBBzdxlH
 f/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=xlADbgHTfgktZnVlMmdmZkILC7FMCjKx16AtkU+w7d0=;
 fh=ollTZDQHwcaUpIC3605QNS4v/8i9zvOfJt6ast1oiYw=;
 b=C78jdlmk/tq3/t7VMfE4YH85gacgQdA/Rja8UGtEjyLTRs/5kk+fe19x5Diigp4o3I
 /ksdhQiPhiQNH2t+fQtWtQVPC5J58TpUo4g3IY82YKEa33NtTEoI/eaCde35aICltXeA
 vwDBRef+pLPEWziyJGzNdgB+VDr40igeDyqV+5StlAfkm96Ed/EYELLj3QPalKSWvtts
 6NJ/oEkzqRL2eA0hYobwtNw7Dzb2nMZjNx2HGiUKVHRQnXBcYz1hzL/ae3akFJ5YG5/a
 f5x+/l1W2c37VmsxH/k2gm4kL+nLo4XfVmvKcuHm+YqwPqXGB1PjmzrMvX8UCpYfPvSh
 xE2A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771492371; x=1772097171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xlADbgHTfgktZnVlMmdmZkILC7FMCjKx16AtkU+w7d0=;
 b=sk4376x2EzZqBVXYlYLkKzagM0MzOrtINrkjjYMUQUBhxlqkngE2CyZVOcfFPP4YX+
 SBROPTNSIA6fUnmeGERw3nesxSP/Gl9/Azv8wqq3ikeY0F4Xq+bd6piAMod9Da7XDncD
 VJt+OXWSMTHMOhKlnbEFdy5AHGfHoFULtpkfUBzk6o0uOn8fuzPWwOTBIyAiusOp9F6n
 GVgD2LEcOmj9W31nEajhLqf/nV6bP5oInl664W8r1w+WyH8Fm8M3y100hiIWp1zl7lwx
 VrZK0gNmc1IOkCMoR9LsFUmMWXjhE+RxHvQ4IKFR2+zLARRQSa1jSde62kcNJ83JJO2m
 IeDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBpwMKaF/ZnX6a9A7WWByrAZi9JrJvQBam9yfXTGCLEk2yKcVPnQE5NH7AtO7gHokR6lc=@dpdk.org
X-Gm-Message-State: AOJu0Yxu5sjaNsn2UgRzB91Co80paANdBbl713+AxAY9Xk3gDS/ZZUl0
 AkilO4rzPUMOY3ldz9+OL+D01quEh6DqVCn5oXPyDfdT41rAhShURcy7xis1vDomWK41lEdK+NN
 rbz9+bp8mMEgViMYH6ZxKUm+TU8x4xyc=
X-Gm-Gg: AZuq6aLOj8BGQcqpIsayB1pz5zNXshMOtsGgbJOto5jgQXPQcFeRjuDWoI5iPaztA0E
 av+fvu0D7pyWhJW9Kw7EKZKfjzwlSFNJ03qcwPVHuJ4zmDNjDqTnlRRAoKJxkU9QLMZn1XuU9uM
 M0cmrPGdSUm96dwYPxZaHWtp4F3bkXzNz77pQ7bjJbo64dP3+j5hrwTTOyEEHjWiut23zcILfoS
 wyD3Shi/CfeU45WMzPSBQuVHvBxfK48nBDjvx3AluHdYfsRzuyas68dZMsLOrzWeKnaceqEk2oW
 SrOZyojr7+g9WdK58BFeb0bTU/rOGINN/GctTRVrG8lzedVV
X-Received: by 2002:ad4:5d43:0:b0:888:3056:dc9e with SMTP id
 6a1803df08f44-8974046705bmr257485996d6.43.1771492370524; Thu, 19 Feb 2026
 01:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218090708.2168dd07@phoenix.local>
In-Reply-To: <20260218090708.2168dd07@phoenix.local>
From: Maxime Leroy <maxime@leroys.fr>
Date: Thu, 19 Feb 2026 10:12:39 +0100
X-Gm-Features: AaiRm53jw4xFWVxrQAXliC4JSQZvAzrxF2nm9OHGOJo11AfEHkL0BqENFTECr5o
Message-ID: <CAHHRULVpX+P0UwYYaFF3jj9tGPqqMb-AVQsyDOQXUjU2ZUC7KA@mail.gmail.com>
Subject: Re: [PATCH 00/11] net/dpaa2: fixes and improvements
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: hemant.agrawal@nxp.com, dev@dpdk.org
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

Le mer. 18 f=C3=A9vr. 2026 =C3=A0 18:07, Stephen Hemminger
<stephen@networkplumber.org> a =C3=A9crit :
>
> On Wed, 18 Feb 2026 17:04:42 +0100
> Maxime Leroy <maxime@leroys.fr> wrote:
>
> > Various fixes and improvements for the dpaa2 net driver and fslmc bus.
> >
> > Patches 1-2, 4-5 fix resource leaks on port close and in error paths.
> >
> > Patch 3 fixes a misleading Rx descriptor limit warning.
> >
> > Patches 6-7 replace getenv-based configuration with proper devargs
> > for taildrop and data stashing options. There are still 8 remaining get=
env
> > calls in the driver that should be converted to devargs.
> > Note: the taildrop disable path has never been reachable until now
> > and is untested. NXP maintainers should validate this feature.
> >
> > Patch 8 fixes link status not updating after port stop/start when
> > link state change interrupts are enabled.
> > Patch 9 is a minor cleanup in the same area.
> >
> > Patches 10-11 fix devargs propagation on DPNI hotplug.
>
> Looks good, shouldn't the patches with Fixes: tag be marked
> as Cc: stable@dpdk.org for backport?

Good point, I will send a v2 with Cc: stable@dpdk.org on the patches
with Fixes: tags, and reorder the series (fixes first, then
improvements) to make backporting easier.
