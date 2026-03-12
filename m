Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FB9106705A
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 16:03:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCBCA40613;
	Thu, 12 Mar 2026 17:03:08 +0100 (CET)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44]) by mails.dpdk.org (Postfix) with ESMTP id 7DC99402AC
 for <dev@dpdk.org>; Thu, 12 Mar 2026 17:03:07 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d7447778b9so575000a34.2
 for <dev@dpdk.org>; Thu, 12 Mar 2026 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773331387;
 x=1773936187; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aoZkzPDJ7K1vFWqSZVJzrdd1bcGuReHKR93uuwJkxg=;
 b=05j2VcoGMl4RybJS5ziNqd+LJyCvCNjTRy5f+3ui4LxpZy3vqDH+TKN/Ltrb1T+wFs
 wcW46i0IGwA+WsPJ2ASRFCCzAsrfa1YBvWgOzYlWxQbwWoRFKg9VB/FeKG3YiZmZAvgW
 JnUaa+ReXQjnKU2xn3t/+6ZRu1fsYtcoBtXWhx/Sgh8aWMHe5Rm8hAFYnhkBPeG3VV7e
 CV7a6hvuW2QvOHMaTnYHjMojAsX/j4L4Q4nkNYgZ4I2XFZjEy4ZdJ4Zm3kV2+ySkcRw3
 jmnQPFCEfysF35y+RCkKKG2AzkWG4yau63IP9m7LKWMBgnzVqWsPtzASm4PzP77t0e/r
 Nbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773331387; x=1773936187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9aoZkzPDJ7K1vFWqSZVJzrdd1bcGuReHKR93uuwJkxg=;
 b=KnsZmlEANWlA56WQ4l52DrzYd9yCciNDUKd0CRo/VbeaPrXwhAcpGspzaO0XG/aUOD
 RvbeLl1cwrlC9lUKRRqPSucCJiT5BdMtwvl6QFfzILXGRzl4velKpen2F1gCKJy/KWzQ
 jG+F/JT5d7hMGwZ+4avZOQGiC6xzueGY75Wa+8/1YWtPK/Kgzv0AruPo/Z+4lLSX3Iox
 t2ZaXmq/mItUM4L4fOWhnA1bw0FoM557aw0S9wD7+TubwZ/WexERH7CSC3JDKbSoV2xJ
 ucmSn8i843DuwlGp4deToCLE88LDWnkELPwjGbwhZ0BmMZ64FR5cBcF8/gUdHqGagne+
 zHRg==
X-Gm-Message-State: AOJu0YyK/iDKhSqJvuNkZAkGSX1x+TPt+GMCK6R7darmlale21lmyhE7
 HfmKiBUyxwwiwdJVncYtum4QAFjdRrTh2LGXjgSQOh/Gu9WIfLAdeckKCfUW9BiOg3M=
X-Gm-Gg: ATEYQzxGebAbYlgku/IMIFBgh6VZ5jKfky72/6EmCnxKADOyNfDw8fv4uNV7jeiJ7mt
 DLz30E0vVKVw+3GfzR1s1txznrPRqwm1XFXHN7Ux5knoc6YagZk0L8bZDo80RRuGreJ1PuF+xjz
 tApivgso1C3eaOaQz2ZQdyrY4eC0vXi1UdReH+qORYkfi2+dBNu3aTmemL3B8ETZ4nfFOcYVrIQ
 RKW5w+WvLxdjhoPkdMNfChZpZbdTuoP3ip4P5hdlsZiV7Qn8Q+VZQBX3XlHl+F9QWOZcD5IHo57
 k/gMH875NwHPIKm5EeCSvKz6veWHRsl4YZLAeXfWER6900+k/UklPygHd4GQ7aHxcyJYlzFbY2/
 9t1lDoaaknW9GJaPd7SA62gx+NEfv+rlGeMfZWGX+URWtiY9pV1P/YMZovFiywIrwQtwNHjc42q
 IfVKLIdg5cPuJXHc3gfTLXcUaTdRt4Y7FqMZfK7EmKH1WihQ==
X-Received: by 2002:a05:6830:6c12:b0:7d7:59db:fc5b with SMTP id
 46e09a7af769-7d76a7ea237mr3961452a34.19.1773331386296; 
 Thu, 12 Mar 2026 09:03:06 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae391f5sm4121972a34.14.2026.03.12.09.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:03:05 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:03:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, Rosen Xu <rosen.xu@altera.com>
Subject: Re: [PATCH] raw/ifpga: fix comma warnings
Message-ID: <20260312090303.359d871a@phoenix.local>
In-Reply-To: <abKELl_UQ8uLhSTY@bricha3-mobl1.ger.corp.intel.com>
References: <20260312002337.867771-1-stephen@networkplumber.org>
 <abKELl_UQ8uLhSTY@bricha3-mobl1.ger.corp.intel.com>
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

On Thu, 12 Mar 2026 09:15:26 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Wed, Mar 11, 2026 at 05:23:36PM -0700, Stephen Hemminger wrote:
> > The driver was open coding TAILQ_FOREACH_SAFE() in a manner
> > that triggered warnings. Replace it with the standard one
> > from bsd queue.h.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  drivers/raw/ifpga/base/ifpga_enumerate.c | 4 +---
> >  drivers/raw/ifpga/base/opae_hw_api.h     | 7 +++++++
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/raw/ifpga/base/ifpga_enumerate.c b/drivers/raw/ifpga/base/ifpga_enumerate.c
> > index 61eb6601ea..085fb6db40 100644
> > --- a/drivers/raw/ifpga/base/ifpga_enumerate.c
> > +++ b/drivers/raw/ifpga/base/ifpga_enumerate.c
> > @@ -725,9 +725,7 @@ static void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info)
> >  		return;
> >  
> >  	/* remove all device feature lists in the list. */
> > -	for (dfl = TAILQ_FIRST(&info->dfls);
> > -		dfl && (tmp = TAILQ_NEXT(dfl, node), 1);
> > -		dfl = tmp) {
> > +	TAILQ_FOREACH_SAFE(dfl, &info->dfls, node, tmp) {
> >  		TAILQ_REMOVE(&info->dfls, dfl, node);
> >  		opae_free(dfl);
> >  	}
> > diff --git a/drivers/raw/ifpga/base/opae_hw_api.h b/drivers/raw/ifpga/base/opae_hw_api.h
> > index 57750022dd..63cb616731 100644
> > --- a/drivers/raw/ifpga/base/opae_hw_api.h
> > +++ b/drivers/raw/ifpga/base/opae_hw_api.h
> > @@ -10,6 +10,13 @@
> >  #include <stdio.h>
> >  #include <sys/queue.h>
> >  
> > +#ifndef TAILQ_FOREACH_SAFE
> > +#define	TAILQ_FOREACH_SAFE(var, head, field, tvar)			\
> > +	for ((var) = TAILQ_FIRST((head));				\
> > +	    (var) && ((tvar) = TAILQ_NEXT((var), field), 1);		\
> > +	    (var) = (tvar))
> > +#endif
> > +  
> 
> I am curious as to how this is not causing warnings but the original code
> is. Have we got builds where we are triggering this macro definition, or is
> ever build tested already got the define?

You have to ask to enable comma warnings, I think it is currently disabled
at the driver level.
