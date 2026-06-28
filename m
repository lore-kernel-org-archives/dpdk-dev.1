Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC0CC43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Jun 2026 16:04:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 927C140278;
	Sun, 28 Jun 2026 18:04:57 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 74FCC400D7
 for <dev@dpdk.org>; Sun, 28 Jun 2026 18:04:56 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30e18c3e0b8so1025767eec.0
 for <dev@dpdk.org>; Sun, 28 Jun 2026 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782662695;
 x=1783267495; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAtPcTZY/gZtp3r1wa1Lnu0PKXG9hHcvJRwclUiPfok=;
 b=faFRZ8Ud9oBQk4jvy1f98u+cVkmd+PEARLYbQoOMEZ5f0AbiHbL/J+L4f7j+f1cq3L
 4k1t02PByf5T3wuBwcN60K1qg9Ch2Rv2UdsMBopNhSLC/Z+YiIvaFIsjOyZ1pxovuoYS
 Y4HBOai6pcuV2rK8vO9J8Mg8WmAJc5/Hebikb3smb7T+3E3IO7TjOZfAkvtR8ULwWo+n
 CKA7eC9R36sN8loKu6RVNLpZvITAlNXEhDIioJzgBU2l8GiBn5zKOnklWETFYD1kR1MT
 MCMaSYtigTALJorvkr/H4qI2UETY5GF4j7jGy0vm+gDZFaViqelRgGr8qCBb0lQbPd3P
 LLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782662695; x=1783267495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dAtPcTZY/gZtp3r1wa1Lnu0PKXG9hHcvJRwclUiPfok=;
 b=Lec2vH+SPE1HMQ/JwjjG4U/c8pUAwc0QkBuKJuvNG1Ipk57cYbggnmqV6spBrY+UNR
 ODPbuH7NFUcA0oH4fp4ps20fZuLmgFVRxFnQs0bAfsLuU+/mwhZuY9d14w7LZcVFU370
 rKfccBB4xGtwkY5fhOq1JccXdqlQ/eRNjcejk3vmJ96+TZVwJBJ8c6uPbkWVbTvepTTN
 fNinNZVBvw7xAULhJgDKuW1It8ouJZx3XmEnIKPmsOD8Cxc4L8N4JNfeIPwJqzzF2JEK
 GsGjPagJEvHFMUgAnlqXtsXW9mjEIAEhUvTdN62KfhInkYZ5pul00TeQ0gXoIncKJMrV
 z7NA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZmOIowy/c/ymjXJAl/eXL+L8agzDaKfbRCMGmqepjExmhBBDC9JJu3wNVqjR9BYRv2e8=@dpdk.org
X-Gm-Message-State: AOJu0Yy0ETOLCbPUXivq+fNWC+mkbngV33rMv4XMOqxPFkF3I5Sy4BJY
 +Kr1dKDnXf6jUrtB46/T8CHPK90+fivhj++v1bHB3YycejkcwPVpq5Mv7wcQa+HRO/g=
X-Gm-Gg: AfdE7cnRXzs9B08lvxS8WUvAwwwfiArmSp4Uk3iERJR4V7RIGy3l7YY3eI1Cno0V/Yx
 bddeBcHCOYDG5bH4SReSUCgzT33PojjHcUUzfhnm6RWoVT7qdPAD730uvUA+UKA4PggEMpWIspr
 tLzBIfRTcfX+L/DeagHEaHdSQNpsRcErvYk47Bv9btMJRNtjwNY3+FEPtqXaylRCIppLQVidmhI
 FfZ/CP2Qx/jeGCsavbfXkuydUGW0cvuQXylQh8JZGgchVjZFUPTWLu1Qb26+JIvafE6hUDqIQS9
 wzWNhzRHr9Ag89DBKVYVDq5ADIdD68bFcD6fFafdQ3NudVitDTiBYGIEo1K0AkMkg98K0mnXelg
 zYJljOvA5Lz/Z59+EADIpfxaLaeJ9liIcpnYgUplfk8Z5nrUJKwENo3EZfw7lv11ggWucHHY+GR
 Ob/wOBjT9kWjwdUscJxwPKgxtOeGxh/3UR4yBlZWXdi21ZJC/3fkFD0w==
X-Received: by 2002:a05:7300:3b2c:b0:30c:50cd:840c with SMTP id
 5a478bee46e88-30c84db3032mr13217527eec.11.1782662695067; 
 Sun, 28 Jun 2026 09:04:55 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e95c6sm54053139c88.11.2026.06.28.09.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 09:04:54 -0700 (PDT)
Date: Sun, 28 Jun 2026 09:04:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>,
 <david.marchand@redhat.com>, <bruce.richardson@intel.com>,
 <Selwin.Sebastian@amd.com>, <bhagyada.modali@amd.com>, <rjarry@redhat.com>,
 <thomas@monjalon.net>
Subject: Re: [PATCH v3 2/3] dma/ae4dma: add control path operations
Message-ID: <20260628090451.19970403@phoenix.local>
In-Reply-To: <6db5bccd-f82a-4a31-ab4c-b3addbcbcc94@huawei.com>
References: <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
 <20260625184728.1678328-1-raghavendra.ningoji@amd.com>
 <20260625184728.1678328-3-raghavendra.ningoji@amd.com>
 <6db5bccd-f82a-4a31-ab4c-b3addbcbcc94@huawei.com>
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

On Sat, 27 Jun 2026 08:09:09 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> >  
> > +static int
> > +ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused,
> > +		const struct rte_dma_conf *dev_conf,
> > +		uint32_t conf_sz)
> > +{
> > +	if (sizeof(struct rte_dma_conf) != conf_sz)
> > +		return -EINVAL;  
> 
> This may break ABI compatible

Ignore that suggestion. This is a reasonable way to handle new configuration
functions. You need/want a minimal set of values. If rte_dma_conf grows in size
then the code can add compatability; by requiring a minimum set of values
and then setting the rest to zero.

Something like

static int
ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused,
		const struct rte_dma_conf *dev_conf,
		size_t conf_sz)
{
	if (conf_sz < sizeof(struct orig_rte_dma_conf))
		return -EINVAL;

	struct rte_dma_conf conf;
	memcpy(&conf, dev_conf, RTE_MIN(conf_sz, sizeof(conf)));
        dev_conf = &conf;

Looking at rte_dma_conf the structure has holes and dmadev lib
doesn't validate undefined flags, so it already has future ABI problems.
