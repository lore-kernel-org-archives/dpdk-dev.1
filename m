Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF07CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 13:13:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 505D8402DC;
	Thu, 30 Oct 2025 14:13:21 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E416E40150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 14:13:19 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id EAB03200FE6A; Thu, 30 Oct 2025 06:13:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAB03200FE6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1761829998;
 bh=krqQIhvGTVhRQqtFTUyTVSu6TrkjzOfuE3AIxojSLN4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fIEq7VgeVOeNYXeUcAnWFfg0OYCCuF7c3FJc80ILP43TKgN9Ac7vp9SdCX0AJB+lA
 jEau5C+WqOtD0boUyG+HEELwzOjJYsd5j4VOPRstoQCnvjDYLa48hV7J88948x14wi
 ckQqWYInpl5+Wjh4ixOwqvl5bqxJEcsYw2L9RS3E=
Date: Thu, 30 Oct 2025 06:13:18 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>, dev <dev@dpdk.org>,
 Thenveer Poolakkanni <thenveer.poolakkanni@iwave-global.com>
Subject: Re: Virtio-PMD in Windows
Message-ID: <20251030131318.GA15405@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <PN0P287MB25316B273566FD2CDDF0D83AC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531616EDF3F92036B4E01DFC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531AEA71C2E1A6B25D15680C5FCA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB25314E093834DFBAA35898A5C5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <1c5cad85-1408-4458-9e32-08f45f36c130@gmail.com>
 <PN0P287MB2531E4AB73A84D84E5F3A2DFC5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0P287MB2531E4AB73A84D84E5F3A2DFC5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
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

On Wed, Oct 29, 2025 at 12:09:28PM +0000, Ayshathul Thuhara wrote:
> Hi Team,
> 
>        Thankyou for providing this input.
> 
> In addition we have a few queries while running DPDK in Windows.
> (A) On what scenario or an example,  can Virt2PHY driver be used?
> (B) After we bind the interface using netuio.inf file, the example application testpmd.exe shows "No probed ethernet device". But in Device manager the interface shows available and bind with QDMA. Here we are using QDMA-PMD(https://github.com/Xilinx/dma_ip_drivers/tree/master/QDMA/DPDK) driver. This driver works with Linux environment.(Please let me know if we need to create new mail for this).
> 
> Thanks and regards,
> Ayshathul Thuhara
> ________________________________
> From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
> Sent: 29 October 2025 11:56
> To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
> Cc: Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>; dev <dev@dpdk.org>; Andre Muezerie <andremue@linux.microsoft.com>
> Subject: Re: Virtio-PMD in Windows
> 
> Hi Ayshathul,
> 
> Adding Andre as currently the most involved Windows DPDK maintainer.
> 
> Virtio PMD could work in QEMU-KVM on Linux host with Windows guest as PoC.
> However, the patches were never completed and merged
> because of a few toolchain-related issues that no one had time to resolve.
> In DPDK, the latest patch is this
> (check also the link in that message and the discussion):
> 
> https://inbox.dpdk.org/dev/20210815145614.3826-1-u9012063@gmail.com/
> 
> In DPDK kmods repository, you'd need to add PCI IDs to the INF file.
> 

Hi Ayshathul,

I don't have further context on this, but let me know if I can help with this.

Regards,

Andre
