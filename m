Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A317FE909B6
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 14:39:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88C9540261;
	Tue, 17 Feb 2026 15:39:01 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id A5300400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 15:38:59 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48069a48629so40337385e9.0
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771339139;
 x=1771943939; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eT9UQar/qHxj4liSEngetXURISyrrA3KTTaOK4Xav8=;
 b=YMwl4K/bj5h3prYvQPRoX7uMUTtayEogcuzw4BU9R0Xx79/hRi1j5JB4Bfyut7zxVm
 ETGM4o80dsuuQkgWlDWnT5qtOWWwYPoKNX5YdtKM0Rsae50awOeLuWTmvwdcbZDNrxUC
 Z/asDgej4Ku3MFLRUF8Vg1tDnRvFdjT/HDx9K31BYnD93gtRo5Kc6NxNhn8WVQAQV7m5
 qNWP/PSMFz/jhVG13AqY9vmzAo2WAxz8xCxx9BZk4Iv9VnVnuP0oVxk3TGy2P2sIx7f/
 tJv/1k9AlZSCoVIVQ8Y8yWgi/8AlRy4BMZxNEWQ8ccCx2kK7nyivLb3JiR+3mTYNTwiN
 wfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771339139; x=1771943939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3eT9UQar/qHxj4liSEngetXURISyrrA3KTTaOK4Xav8=;
 b=N/itHg4y+19Vf4A3he2h51bNvb1DT0rQH77SRbDZDA1QPw8QKVhCKc3KwSDPsRZyoK
 fcKhGUzLzZHrRGKv1Ow/qJ99AyoDArWM6s7bixBIwiFx8E23wqBz7fE+LZsYrWbAdujI
 8lD89W8KL79ul04reT0dgzj+A5gM5SdcffhbsvCWWbQcfDSO6lI9V+aRLN5QvN3tbD6E
 kc6mxc9QMHz6d7LIEDW10onm0x2EDiwolB638nv8NpkqdQYQrVUngoHKIK4q5yla+JTv
 Y9U2CRZSDgElpVsMRlWVrNVDcrDJhXVQur+jwTLKeA4BXNJOBHpPTIfDw+7lzboX731b
 CFqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTMnizYvXgc9uVufeEK4WdPv3pvLCw+/3TSzdoacw1MIMpftayE6KGwmm6BRS7N91Vwxw=@dpdk.org
X-Gm-Message-State: AOJu0Ywo2wGdUkxhCP1vHesYV+9AZK3gx7DHxcPz0UJ5Nu6mPiR5Cr0i
 jLSNlQwSg7Ki4rx9ct/c5GcheNzzQsz973Yvw+YyvzywEnrU5vyzMq93fTD8qPg62JQ=
X-Gm-Gg: AZuq6aI+4RvzCxDa8zUSrLyjEYxyj1769jq4HbzsMff48fEDGp/orZkTt/n7B8KBZV2
 OhQiAGkvEgT2k8qhYm3kpkfreDtmziPdJQFNYvdLwOaMKTIjsHNKaFE2EvLGajTogEp4tbKRQN9
 AOHoaO1UtK7f0ymudT1nKK35pulfB86HHSNZ4ZeDEvs6ivML50KyBrt+enExCjMAaoCy8sAlyS/
 43eP71nzg0EnzkJ5kD4oEwIgRGFjrgv7nOUn8wORGjj+Wngok+htsS4MrnHVJPbG8ISW3jGIoVq
 cybLQCeyWbktdEaTET/se/Eb72ZiCxCccDsCFQSedCcEMurpCQlGK9wM2SHGYw+cxvKxl6hsRNL
 DB8fMsDvsbh+S1ZGM6Xa3dhaCLRuZcm1a5CQvZlxA6JTY432aA0perD0i15yEsh5v7xuDaP661/
 BgmPbRrgMPF8DP+3Xi+DkKeqIZ6m0uLN+o5Uh/DKJutpSovwvz3RdvS6IIJx8LpBbs
X-Received: by 2002:a05:600c:6211:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-48373a09741mr254570195e9.10.1771339138796; 
 Tue, 17 Feb 2026 06:38:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a2998fsm106530645e9.17.2026.02.17.06.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 06:38:58 -0800 (PST)
Date: Tue, 17 Feb 2026 06:38:52 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: "Burakov, Anatoly" <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v3 10/27] net/i40e: avoid rte malloc in RSS RETA operations
Message-ID: <20260217063852.53214dcd@phoenix.local>
In-Reply-To: <aZRjNHlyUumWaEwP@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
 <18276a5e4876d084096cccf6f40ef9af87fedacf.1770817884.git.anatoly.burakov@intel.com>
 <aZNOm5EGcN7uSeVt@bricha3-mobl1.ger.corp.intel.com>
 <ad1ce316-2694-451e-8a51-2008a65cd8b5@intel.com>
 <aZRjNHlyUumWaEwP@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, 17 Feb 2026 12:46:44 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Tue, Feb 17, 2026 at 01:32:05PM +0100, Burakov, Anatoly wrote:
> > On 2/16/2026 6:06 PM, Bruce Richardson wrote:  
> > > On Wed, Feb 11, 2026 at 01:52:52PM +0000, Anatoly Burakov wrote:  
> > > > Currently, when updating or querying RSS redirection table (RETA), we
> > > > are using rte_zmalloc followed by an immediate rte_free. This is not
> > > > needed as this memory is not being stored anywhere, so replace it with
> > > > regular malloc/free.
> > > > 
> > > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > > ---
> > > >   drivers/net/intel/i40e/i40e_ethdev.c | 8 ++++----
> > > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> > > > index 06430e6319..654b0e5d16 100644
> > > > --- a/drivers/net/intel/i40e/i40e_ethdev.c
> > > > +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> > > > @@ -4630,7 +4630,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
> > > >   		return -EINVAL;
> > > >   	}
> > > > -	lut = rte_zmalloc("i40e_rss_lut", reta_size, 0);
> > > > +	lut = calloc(1, reta_size);
> > > >   	if (!lut) {
> > > >   		PMD_DRV_LOG(ERR, "No memory can be allocated");
> > > >   		return -ENOMEM;
> > > > @@ -4649,7 +4649,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
> > > >   	pf->adapter->rss_reta_updated = 1;
> > > >   out:
> > > > -	rte_free(lut);
> > > > +	free(lut);
> > > >   	return ret;
> > > >   }  
> > > 
> > > For i40e do we not have a reasonable max reta size that we could use for a
> > > local array variable, save allocating and freeing entirely?
> > >   
> > 
> > It's on the order of kilobytes I think so I decided against stack allocation
> > for this scenario.
> >   
> If it's only a kilobyte, I would tend to go with stack allocation.
> However, it's up to you.

Agree, anything under 4K seems reasonable to be on stack.
