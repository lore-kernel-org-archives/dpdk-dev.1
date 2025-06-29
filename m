Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C68C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:30:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEB78402D2;
	Sun, 29 Jun 2025 19:30:05 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8BFE140288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:30:04 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so3028672a12.1
 for <dev@dpdk.org>; Sun, 29 Jun 2025 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751218204;
 x=1751823004; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eji4GDrRMdhuLtv0CVyIEMCFWI7iNQzUTDt3SssjtV8=;
 b=1x/i17YfuWvO20idUhmLHcXAXzj5vumTNUu+eUgf1wX6TdLqhzy/bcl2QGhJJZw529
 22u9J/tkWndQX6xDbXTGH5IrXmcuF03uFwY2aSytwVCUZdDLRsos6xs74Lgi4Sn9FXQZ
 vGmDSw553gT1p0GWL+D7EBJnq66NtdV6AYEcODmHahBs3aPPjwyrCwNIA2VguYtIRAf4
 os75NAHO+01viWOiVzvoz72399GnezjxUuQ+ENagIHwPDviDB4r6T+UCgM66yVVZcQBr
 Fdc2rVSrGIukSj8JVCQsq2YHrESfe88tHqkuzywWtLQRApJvLy3aunnk+x92yjadVgH4
 /o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751218204; x=1751823004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eji4GDrRMdhuLtv0CVyIEMCFWI7iNQzUTDt3SssjtV8=;
 b=GFagpY0DLcXUQihVTp2hc0ocyb0kWcUX4fJVvOue9heeQlpqxBwnM9WaFNonlc69SV
 eWsirxjnvMs0z8NmaxfQKieY+SRKks/Aq3hPvgBN7LekiI9CAcOQbnJNfE0IcxbwTIYy
 H3TEIowMWqZp6b0BeDY8pZddxUGXl6dVjh1efOi/rGp+6TjsjPEJerglZGRAbpMlBSgO
 dzTvkDSbnI5qaOEB4Z43qoOlRBiauU+q1G/p/fkIVeIlAO4BYLyugt/Xaenr7yo5WjpJ
 Egc7pfjavqAfPKQ/nMthPJ4mziBLBUHtbLBIHbRwQIrYF/vQx9KYxebQWm5HKaELX9qa
 6LRg==
X-Gm-Message-State: AOJu0YwL5olJupgPrSJehHzoey0d1SfjGc9m+OcURXCp8zE4sonCUqpL
 0IJAKNssCyIyEC61u34MiW57xmWr6gIBW+b6/076JklvrWcWuBgjQAku8ANaDjiAnpE=
X-Gm-Gg: ASbGncuLG84ot95QUoj6rbrbTmTV26suza//ben444K8FNM18kDJWFr9RAHRBE6QzOA
 rcIq/YJcPDkkJdFtx+C1IYmTNWcnDpkTQiV62EEPaP7uXdcMxw2ukbDuKJIHo3rWmFoVMx5qQWw
 tGw4EleoisFGwfXjho6bso1qFq119gFFP4WZ8ljWxIJRIRDqturhjIGDqiIAaf+wAU4QJX/hlBb
 BRDgjG6pDLDi5MZdZsSFw3ZXgTm7QYi1oi9iTI0prQ4c3GHt1C0puK8IfC/p73+t/QPu47LrfF/
 rIAoHD4qlIotyKYwUS7QxKTsJ+KQz6fIsCMTbyHEuMoPpPJNwfCVMqX4RlEKCAx20XdxqJD0lXD
 E8wHb6YzXf1jwq/MOGBf70K1uXGB6LyAh4JBVIDs=
X-Google-Smtp-Source: AGHT+IFeZOkTRcCLCzqBbZ+elbet267zA1EgpS6OVzwWyNaVJe0+bu+ZycK1EF2hTlxq6PbBKZTxbw==
X-Received: by 2002:a05:6a20:2d0c:b0:21f:563e:b7ff with SMTP id
 adf61e73a8af0-220a12766b8mr17987174637.2.1751218203707; 
 Sun, 29 Jun 2025 10:30:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55788f5sm6775991b3a.97.2025.06.29.10.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 10:30:03 -0700 (PDT)
Date: Sun, 29 Jun 2025 10:30:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] ethdev: sync ethtool link modes with Linux 6.15
Message-ID: <20250629103001.337c7516@hermes.local>
In-Reply-To: <11997994.uMvqGB8zbg@thomas>
References: <20250625134202.3193570-1-thomas@monjalon.net>
 <20250626072651.79d51099@hermes.local> <3888072.ucjEoNaZvj@thomas>
 <11997994.uMvqGB8zbg@thomas>
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

On Sun, 29 Jun 2025 18:37:31 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 26/06/2025 17:13, Thomas Monjalon:
> > 26/06/2025 16:26, Stephen Hemminger:  
> > > On Wed, 25 Jun 2025 15:42:02 +0200
> > > Thomas Monjalon <thomas@monjalon.net> wrote:
> > >   
> > > > diff --git a/lib/ethdev/ethdev_linux_ethtool.c b/lib/ethdev/ethdev_linux_ethtool.c
> > > > index ec42d3054a..f508cdba6c 100644
> > > > --- a/lib/ethdev/ethdev_linux_ethtool.c
> > > > +++ b/lib/ethdev/ethdev_linux_ethtool.c
> > > > @@ -17,8 +17,9 @@
> > > >   *
> > > >   * The array below is built from bit definitions with this shell command:
> > > >   *   sed -rn 's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;'\
> > > > - *           '[\4] = \2, /\* \1\2\3 *\/;p' /usr/include/linux/ethtool.h |
> > > > - *   awk '/_Half_/{$3=$3+1","}1'
> > > > + *           '[\4] \2 \1\2\3;p' /usr/include/linux/ethtool.h |
> > > > + *   awk '/_Half_/{$2=$2+1}1' |
> > > > + *   awk '{printf "\t%5s = %7s, /\* %s *\/\n", $1, $2, $3}'
> > > >   */  
> > > 
> > > The commands in the comment never worked verbatim.  
> > 
> > It works on my machine.
> >   
> > > $  sed -rn 's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;'\
> > >            '[\4] \2 \1\2\3;p' /usr/include/linux/ethtool.h |
> > >    awk '/_Half_/{$2=$2+1}1' |
> > >    awk '{printf "\t%5s = %7s, /\* %s *\/\n", $1, $2, $3}'
> > >   
> > > > > > sed: -e expression #1, char 63: unterminated `s' command  
> > > awk: cmd. line:1: warning: escape sequence `\*' treated as plain `*'
> > > awk: cmd. line:1: warning: escape sequence `\/' treated as plain `/'  
> > 
> > The backslashes were added to help the syntax highlighting.
> > But I can remove them.  
> 
> Unfortunately we cannot remove the backslashes,
> otherwise compilation of the comment is failing.
> 
> 

Put original patch into next-net
