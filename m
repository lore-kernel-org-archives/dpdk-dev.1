Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDF0C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 18:39:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6379F4025A;
	Tue, 11 Mar 2025 19:39:12 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A0E444014F
 for <dev@dpdk.org>; Tue, 11 Mar 2025 19:39:11 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id CA6412045FE0; Tue, 11 Mar 2025 11:39:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA6412045FE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741718350;
 bh=KWC+znFamMZY4M5ToJNGOOZV/fxiAjjfOd02RDNzrJU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lGZ818dllBrP7JSWJ7NgKS2TMw6541lurx4IUggsP4faKMcGSzud3C6Gi8AKbvFTL
 a7nRtm4a2mG8JFWjGHWgrDJbNkolyfUEwhGRycXN01FohTK9AUlhrBQvQSIMYwcrp0
 qREN7FLUrxolG8Ruyy7Z8snARr9nADPu179/a2sE=
Date: Tue, 11 Mar 2025 11:39:10 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH v3 4/5] net/intel: use portable version of
 __builtin_add_overflow
Message-ID: <20250311183910.GA13271@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
 <1741192690-26243-5-git-send-email-andremue@linux.microsoft.com>
 <Z8iBOZuIq-Zael91@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iBOZuIq-Zael91@bricha3-mobl1.ger.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Wed, Mar 05, 2025 at 04:52:09PM +0000, Bruce Richardson wrote:
> On Wed, Mar 05, 2025 at 08:38:09AM -0800, Andre Muezerie wrote:
> > __builtin_add_overflow is gcc specific. It should be replaced with
> > a portable version that can also be used with other compilers.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  drivers/net/intel/ice/base/ice_nvm.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/intel/ice/base/ice_nvm.c b/drivers/net/intel/ice/base/ice_nvm.c
> > index 56c6c96a95..1002a6b59f 100644
> > --- a/drivers/net/intel/ice/base/ice_nvm.c
> > +++ b/drivers/net/intel/ice/base/ice_nvm.c
> > @@ -3,6 +3,7 @@
> >   */
> >  
> >  #include "ice_common.h"
> > +#include <rte_math.h>
> >  
> >  #define GL_MNG_DEF_DEVID 0x000B611C
> >  
> > @@ -469,8 +470,6 @@ int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
> >  	return status;
> >  }
> >  
> > -#define check_add_overflow __builtin_add_overflow
> > -
> 
> Rather than modifying the base code, can you instead add a #define to the
> osdep.h file in the base directory to alias the new function to
> __builtin_add_overflow for MSVC. The other files (other than osdep.h) in
> the base directory, come from a common/shared source that is not DPDK
> specific, so we try to avoid modifying them where possible.
> 
> /Bruce

The problem is that the file below defines __builtin_add_overflow itself, so
it does not look like we can completely avoid changing this file.
I can still make the change you asked for, but the patch will have to remove
that define from the file under base.

drivers\net\intel\ice\base\ice_nvm.c
--
Andre Muezerie
