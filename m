Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3614C83F21
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 13:57:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66AFF4028C;
	Tue, 15 Jul 2025 15:57:28 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5E3614021E
 for <dev@dpdk.org>; Tue, 15 Jul 2025 15:57:26 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 73DBE201BA16; Tue, 15 Jul 2025 06:57:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 73DBE201BA16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1752587845;
 bh=QmH6uC7ALd2HgO1azsO0I7KAiZiSEw35HONjvYD092w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m5E5wij8kKOVdOGUpn4jE0GMsiPWhh1pHAXj5ctGUMGPviAuh7lhtB3jp3MyVFtkh
 AbzC1mtw7EsmgiMnIds76FK4jDJFyieellPX8njTYO/+IWsQuVSeQIgQjsGsS9ICIp
 H2G6bhReX1DMj9ZN5OzLD72FOaJN7Lzxw6WYpnBs=
Date: Tue, 15 Jul 2025 06:57:25 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org
Subject: Re: [PATCH] doc: update parameters to use for mlx5 on Windows
Message-ID: <20250715135725.GA21424@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746458561-13525-1-git-send-email-andremue@linux.microsoft.com>
 <20250715120345.rnr6x5bm5l3wqw5m@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715120345.rnr6x5bm5l3wqw5m@ds-vm-debian.local>
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

On Tue, Jul 15, 2025 at 02:03:45PM +0200, Dariusz Sosnowski wrote:
> Hi,
> 
> On Mon, May 05, 2025 at 08:22:41AM -0700, Andre Muezerie wrote:
> > The linker parameters to use with MSVC and Clang differ.
> > Showing explicitly what to use with each in the documentation.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  doc/guides/platform/mlx5.rst | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
> > index ab3107209a..7a5bea3b49 100644
> > --- a/doc/guides/platform/mlx5.rst
> > +++ b/doc/guides/platform/mlx5.rst
> > @@ -268,14 +268,26 @@ configured by the ``ibverbs_link`` build option:
> >  Compilation on Windows
> >  ~~~~~~~~~~~~~~~~~~~~~~
> >  
> > -The DevX SDK location must be set through CFLAGS/LDFLAGS,
> > -either::
> > +The DevX SDK location must be set through CFLAGS/LDFLAGS.
> > +When compiling with MSVC, use either::
> >  
> > -   meson.exe setup "-Dc_args=-I\"%DEVX_INC_PATH%\"" "-Dc_link_args=-L\"%DEVX_LIB_PATH%\"" ...
> > +   meson.exe setup "-Dc_args=-I\"%DEVX_INC_PATH%\""
> > +   "-Dc_link_args=-LIBPATH:\"%DEVX_LIB_PATH%\"" -Denable_stdatomic=true ...
> 
> This long command line can be split for readability,
> using caret as line break:
> 
> 	meson.exe setup ^
> 	  "-Dc_args=-I\"%DEVX_INC_PATH%\"" ^
> 	  "-Dc_link_args=-LIBPATH:\"%DEVX_LIB_PATH%\"" ^
> 	  -Denable_stdatomic=true ^
> 	  ...
> 
> The same applies to commands for clang.
> 
> >  
> >  or::
> >  
> > -   set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-L"%DEVX_LIB_PATH%" && meson.exe setup ...
> > +   set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-LIBPATH:"%DEVX_LIB_PATH%" &&
> > +   meson.exe setup -Denable_stdatomic=true ...
> 
> && are not really needed here and
> it can be splitted into multiple lines for readability:
> 
> 	set CFLAGS=-I"%DEVX_INC_PATH%"
> 	set LDFLAGS=-LIBPATH:"%DEVX_LIB_PATH%"
> 	meson.exe setup -Denable_stdatomic=true ...
> 
> The same applies to commands for clang.
> 
> > +
> > +When compiling with Clang, use either::
> > +
> > +   meson.exe setup "-Dc_args=-I\"%DEVX_INC_PATH%\""
> > +   "-Dc_link_args=-Wl,-LIBPATH:\"%DEVX_LIB_PATH%\"" ...
> 

Thanks, that indeed makes the commands easier to read.

> Shouldn't clang linker parameters stay as it was previously i.e., "-L..."?

Not on Windows. It can be confirmed by looking at build\meson-logs\meson-log.txt,
where it can be seen that the -L option ends up being ignored:

Sanity check compiler command line: clang sanitycheckc.c -o sanitycheckc.exe -IV:\soft\MLNX_WinOF2_DevX_SDK\inc -D_FILE_OFFSET_BITS=64 -Wl,-LV:\soft\MLNX_WinOF2_DevX_SDK\lib
Sanity check compile stdout:
LINK : warning LNK4044: unrecognized option '/LV:\soft\MLNX_WinOF2_DevX_SDK\lib'; ignored

As a result the lib mlx5devx is not found:

Has header "mlx5devx.h" : YES
Library mlx5devx found: NO

I'll send out a new version of this patch with the changes suggested.

Best regards,
Andre Muezerie

> 
> > +
> > +or::
> > +
> > +   set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-Wl,-LIBPATH:"%DEVX_LIB_PATH%" &&
> > +   meson.exe setup ...
> >  
> >  
> >  .. _mlx5_common_env:
> 
> Best regards,
> Dariusz Sosnowski
