Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D45DC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B13040292;
	Thu, 20 Feb 2025 17:10:03 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6121640041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:10:02 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-220d601886fso17598535ad.1
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740067801;
 x=1740672601; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6vKG3QG2ZkLysSL0Of2zVSbC+zFzlOy5WmNpYZtuuw=;
 b=3QLl4jRHFZADKkrgRxUABdajJmo5twkkUDwC7dYabaLtXZpxYr8aRQblgd+yo/aZGq
 49VG+47DHVX+0seK/c8M4kaibJP5tOWeK/EP7RiyJrLeDXOA0vXXMVTeHYJOqE/Vyhgn
 6Vqs2F9Kw0E++Nlhid0HFFpMlvbBnqhjq+D2FC51JJ2qe91rVSdBNTan/fq6oPo4JbXX
 f+Rbc4o/ukDkDCc9c9JbzBX9aSj1kHDMvhRVdM2OSG/aeYjucN66DKQxn3SVHN+/jywA
 oIjWfNLIU53Cx3AB3dZfvfsfv9Nrhuz1QKj+mATamCLR++hnFOD3d8F/IE7t3nAI3Foy
 NK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740067801; x=1740672601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6vKG3QG2ZkLysSL0Of2zVSbC+zFzlOy5WmNpYZtuuw=;
 b=P9ZTS0UBqPdz7fboqWgpfhxOfsfdnAjJ8sWg7EaYmA8uJH9NIFOWUMPtn/75oIApGv
 dvtod/xqm+f5qUJMWmsXQFpkwUCOr/bhz0QJGOnCiB+dLoMWCH7G+44AzAf4nOtIPCdd
 LRHdi2JACl6/Q5bhAUIvTXfdW06mqpSfdatt/EK4rDtZCNFmQ9PpWI7pjAD5nEex7kGS
 3Z7+7/Q/eNr9tiyTsCVgEY8R0RhuDkygwX6D7iF8mpD7f8WqwrFgt/+gGY6oGwirimAy
 6NEoYXJDIQu9DavX+INwlysP4GkjKTm11HS/cj53/vhRw3UA5xnWzHCwUflNpqRdmYMt
 RkLQ==
X-Gm-Message-State: AOJu0YwjqZ46kt3Ku3v6pkPkhK2S9mihkf93s1JNN+7FBH6bSsrUNZ2c
 qScEV5wj6Bzp24pTr4yn3xCQg18QgUOb3BwbDyeMB6/dAujOAoDINSbyoFbbs1iIy7Iubkj1HIW
 5
X-Gm-Gg: ASbGncvfwP654QbwrYvLf0veCUJXPK9iTOqnI+pmPPnE0CNjyehBxbf5pzG7Am++EFJ
 WKmSdXlGFgO813fPivl1uaCXWRU2ufQOt99SefYFYc+v1b6Otea7GgfwEHn9B7za7RJKon66P61
 nSZgalRzVv5ojsgK/EuNL3gXDTg/mCavh9DdsacS5Z4w0Pfmt+S9ukIJHjfKpzbHKo8GJoyK1MZ
 N+H8jHmsiHLesAIF8A6+EzcjCBrQN/nToqQlt3ntAekQ5PPMZ8Ajtmm4N2YyURfl9fE85ot3CqR
 3Mrwnj+Ovx4o0d6ayhoH5FEWa2/v9AyftrezLGoqzwts2+bc/zRwX8kKx8UDXmA/BA27
X-Google-Smtp-Source: AGHT+IEY472Xc5kDRx+0cH2RN+MlEF3E9+RcjZ/Q19tZajCgfa7eJwVhBTKddAnk4tVMQFIy+TQROQ==
X-Received: by 2002:a17:902:c411:b0:220:efc8:60a8 with SMTP id
 d9443c01a7336-221040541aamr414134285ad.28.1740067801331; 
 Thu, 20 Feb 2025 08:10:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d534954bsm121460445ad.27.2025.02.20.08.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:10:00 -0800 (PST)
Date: Thu, 20 Feb 2025 08:09:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>
Subject: Re: [PATCH v2 01/14] ethdev: remove unnecessary deref on function
 pointers
Message-ID: <20250220080959.6249c5f4@hermes.local>
In-Reply-To: <2786d5f9-2f14-4af6-a4fe-ed3827c24f0d@oktetlabs.ru>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
 <20250220023509.630569-2-stephen@networkplumber.org>
 <2786d5f9-2f14-4af6-a4fe-ed3827c24f0d@oktetlabs.ru>
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

On Thu, 20 Feb 2025 10:09:23 +0300
Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru> wrote:

> On 2/20/25 05:32, Stephen Hemminger wrote:
> > The expression *dev->dev_ops->rx_queue_start and
> > dev->dev_ops->rx_queue_start are equivalent.
> > Remove the unnecessary asterisk and parenthesis.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> 
> Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> 
> one nit below
> 
> > @@ -6995,11 +6966,11 @@ rte_eth_ip_reassembly_capability_get(uint16_t port_id,
> >   		return -EINVAL;
> >   	}
> >   
> > -	if (*dev->dev_ops->ip_reassembly_capability_get == NULL)
> > +	if (dev->dev_ops->ip_reassembly_capability_get == NULL)
> >   		return -ENOTSUP;
> >   	memset(reassembly_capa, 0, sizeof(struct rte_eth_ip_reassembly_params));
> >   
> > -	ret = eth_err(port_id, (*dev->dev_ops->ip_reassembly_capability_get)
> > +	ret = eth_err(port_id, (dev->dev_ops->ip_reassembly_capability_get)  
> 
> Why are parenthesis kept above instead of moving to the next line and
> remove parenthesis as it is done in the rest of cases?
> 
> >   					(dev, reassembly_capa));

Thanks, will fix in next version.
The parens were not caught by the regex used to do global replace.
