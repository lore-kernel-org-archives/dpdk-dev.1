Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57537E87846
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 16:24:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A4D34029D;
	Tue,  3 Feb 2026 17:24:30 +0100 (CET)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by mails.dpdk.org (Postfix) with ESMTP id 04BFD4013F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 17:24:28 +0100 (CET)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-56641200d6eso4582940e0c.0
 for <dev@dpdk.org>; Tue, 03 Feb 2026 08:24:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770135868; cv=none;
 d=google.com; s=arc-20240605;
 b=fhrW9kaNUJqdChutemyce1eMlVLy701E8YMPQQOhKLvu8+DcoOXkHt5nrxuoMfI7Q5
 uJlxBZR9gKoJjKNDnayQ4L/tFo3sHp60cukjj9PJLaQ3fyYurkliNdWKX97mCA99qZMH
 oxuKNluaU+PBU28GGlywZRNHmbAhOyL+ulyouEnhNe6OKpZlDTIEQQpTP4Dy3D/2Ynkt
 aHMUf8luObnZ2vYsmGGpb8TyovnV6H+ByWzWgv3J2z5fAcX8GsFsKDVcMT+gbvCU9esP
 b9n1lkWY9fjVz1tv0aedqZBYQcLATunY4vXs7oGB5Oeh/bk2jmnIRIa9555X2Whh4eHH
 sdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jiP9LEaMl08K2s4+amhwAIn3G/HTfTq5NALAcGmIvRM=;
 fh=7hGAxMJ0ahU9WdmcbH8esh2qqgZqbutD5AFuMCFFoQY=;
 b=YDtzVJrRn11F7ptiz0lik4f5qemUO+p/TlS+58FrJip9lNtS4i/Y+n57nPnHREqDtY
 MtaZnLWkUIGt7Kq9svD/AUKEIhkiwxcK82xzSeJuvAgjTUaVGU4hGMxVp4GcxnZ28qUG
 S9WvMEF48XFj6t1O+6Hb2kOcZzZxbKMeUGs030vbh5TxN2q6tlt7D68cCDi1RqAvyjVc
 A0iyN14YmDbWuwCNIqIzFAM7umikSCUQozP2g5gH/y5oADKwZPUXFF/CTwxwy4B1u37m
 pt/pU1iT+hTSvWi1cn+2lXGDe1MHYc2TOWOypTtZ9D6/840ScK29TAJ4k2wzHt3ZWDPu
 fYZw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770135868; x=1770740668; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jiP9LEaMl08K2s4+amhwAIn3G/HTfTq5NALAcGmIvRM=;
 b=BO6O4NlcGt0YgVcli2FdPJJeu21zme8NZFNmuW09tcOgV5utDz9ji0UJtsEGZZj4Bu
 eXk3XoWt85K7rV06Bi0AQvycKycMCCRaj0FBprzwQcILLTqMdrdIz+2gdfQmmKzEGc5x
 T44QJp8OrkndbZuoFw+p54x3/fOIreCQ5tBbCi6BlF7U+4fRTDdJBxmQqKnj1I87/7zV
 /5Bbt0XxExPlW8vIdn8bcrDANM8ec6UrKcBv2XRWNU2IbqUI+YgNUPm58O7mUay9IVL/
 4kEYRgNwA2Zh70iCrsNVEuxgNkBNAMikbd93njmvB9CI3YqGuX1m31fFVm4m0Fnm7Lv8
 YYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770135868; x=1770740668;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jiP9LEaMl08K2s4+amhwAIn3G/HTfTq5NALAcGmIvRM=;
 b=sZdPKGvUvUbzkAUOirwU9vuQXXK+OsIcVW+B5XlzjFyeuQe42uP7QsrbktzGnHH3cH
 Jvl3kqpP0WpB0L3bBcKNz83kfVyhpR1UcRyTl2BvlPIsO9bKNkDUjggyJuxNAsZy8xCO
 RQHufgi29hS5IdEgXCYSBb1KgAyYqREPSYu2e3Yhj3jm0v7VyprY27g2Q66MB2inhXXy
 i9OfgkAxUyLBOaMFwzB/J9MFw82dzH+jds2L1HxdfaSzD7fUphJ+dl+mulkIx7vBvfyH
 kt5F2jgMttMSWkdeAZeVWqKYbC3VMTPSx3HoqwMIP05EQOL+AVn9h2k5ZW3eo6/58xcx
 s31A==
X-Gm-Message-State: AOJu0YxI4EKbWMR3Hz0WO1wcJ4jUOyd7JmqbgiJOa4BLdPqmTNfhgf4W
 2Hu9w41DA0XH1y9Ee8sM+JalsNoJMJ2MNUkx/OplSvzcq5kQRjQJieivJq/qyo4cDFYxKeRvkfs
 weO6eOSLiVJRi+xJDFer1nPlXqX1Vgu4=
X-Gm-Gg: AZuq6aLrUtI7y/sEpfhfJrJiJfpQ99yZnkMK0TMvNhiwHvlh+tq42wkhY+bAfaEaotU
 AX3i7XhMDyCJT09ieNMQnqCgQaeegMeMWS2dIHoptT/SbI7sJqihURUiUXogqFRU9/2s3CVqL/t
 MpladPiFtd2pqD5Iok4piWJdx1ZyyMcat0AIzoVwzSw6NmNdKn2e5pw90+8Qk24ky5UCGzgyeTX
 q7KIM4T/l1ztVsQtTVyUPveqGiDAM5iCrZzxY+Iu1SfCMG20iGGRKrhyweylf470+m11YWN9g==
X-Received: by 2002:a05:6102:834f:20b0:5f5:3619:8bd1 with SMTP id
 ada2fe7eead31-5f9395ae2d3mr57342137.25.1770135868022; Tue, 03 Feb 2026
 08:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20260127052900.68045-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-3-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656E6@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656E6@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Tue, 3 Feb 2026 08:24:16 -0800
X-Gm-Features: AZwV_QhR250Z7ON6fWtkm8ZuYU_fqjGxNS3FFWZoHRWCo-2sJK1N5UfT8E5-dEc
Message-ID: <CAFn2buDSgJsRShZP-LO00rH2Uv_9sMUHSM6jwhbukH3fZzrpWg@mail.gmail.com>
Subject: Re: [PATCH v17 2/2] eal: RTE_PTR_ADD/SUB API improvements
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, bruce.richardson@intel.com
Content-Type: text/plain; charset="UTF-8"
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

> Again, thank you for all the work you put into this, Scott!

Thanks for all the feedback :)

> > 2. integer types that represent pointers
>
> Please get rid of all the RTE_INT_PTR macros.
> IMO, these macros look too much like plain wrappers around simple +/- operators.
> It seems they are only needed for the cnxk drivers; those drivers can probably be fixed in some other way.
>

Sounds good. Looking at the current state, cnxk doesn't even need
them. Just 1 usage in eal_common_options.c I can cast and work around.

> > +     RTE_ASSERT(mi);
>
> Preferred: RTE_ASSERT(mi != NULL);

Asserts updated
