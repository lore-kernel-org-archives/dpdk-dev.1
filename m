Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B53CFD313
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 02:03:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B0DC402BB;
	Mon, 24 Nov 2025 03:03:11 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 16810400D7
 for <dev@dpdk.org>; Mon, 24 Nov 2025 03:03:08 +0100 (CET)
X-QQ-mid: Yeas3t1763949783t694t54122
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [36.20.107.59])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 16536297905024859870
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	<zaiyuwang@trustnetic.com>
References: <A4E8D8476CBBC191+20251119085624.73210-1-jiawenwu@trustnetic.com>
 <20251119214756.6642de30@phoenix.local>
 <026101dc59e6$5f908850$1eb198f0$@trustnetic.com>
In-Reply-To: <026101dc59e6$5f908850$1eb198f0$@trustnetic.com>
Subject: RE: [PATCH] net/txgbe: fix the missing old mailbox interface calls
Date: Mon, 24 Nov 2025 10:03:02 +0800
Message-ID: <001701dc5ce6$7757aba0$660702e0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQC9elXKL3qDM07uIHFB8npHaJETJgEpr90PAbZufrm3J9X4gA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mnff/9wu0oJYNZOhQr30h0NXrHdWiP3ff8Bv+156xiw8oIuZb2AIgtGn
 aG+/kLIZd+fUIldz+Inh0S/iBwlRCB71yhmGyeC0uOklKgBjCjNVjv49R07PRRwQqhakeWV
 WCkQZRVNgJ80TaN2icomVK+5mp+F+gX+PsW+eK9INsxv4Mif5BbovQhZ4rbE0uav4AsTCsQ
 rGD/nA1JI+9fwdFUTwnyTtrrsNBhZOJVdYiFXnlJ+BNEs5Zk6YBIYrsI486hFu9Cu957R2M
 Adxvc+PaxkB88+IoFGKOA8ol8LYr/A254aJOtxB4fP8Wyu6MePCxP3/J+IlMGJrcHD2U6EG
 8ji7ncedWziTk6paY1NzpfC1pK5L0I0qs6/IH6/7yfBLs+Qx8vM7lrCTRX4oOn64CYvoQTP
 kUW1AtScr17aoEsHajFRCPIJ4l+TA7SZqF6P9eJbC+D31o3TP9Id+YYTwLykTBBUdMEQxws
 YADe/qDXqA+xEF6nrJD9QVD4V6uoQGghAGa9lQYjXuOA3KIsnoTlwFTfHnd6Ou48WiPlJRq
 ymz6U3s1Lla4/ZXak9VLMY3Xl8dW9jMfbw/3ILT7bORraV9yigR8Pd7iq9ZVOukym4a1CJh
 RF0yeybfhGTmQHLBkhut9OjFZsWw8mMiwj5omp6h3ceX+TrMpD83Cp4i5h8sOT/J/URwUKJ
 4OGtsqg5MU7qXccDHTKnUEbXbthPY79alr44doCyQ/jGW2B+ghGANKSAh/EIsh06utY7W7e
 FrIGO4YG2LK6Xo5KtyQPOXbUNYdOH+F9QVpH+OSiZq492npbJKS9Xg2vokD0jBCNUCe0I80
 uRrAdtCsDEO0L3Y9QSI0eu/fdMhX4+W3jyqWDG16dgHzufsY+9lr/lVScHlVj+75oOl04QC
 UhdETFhncaojYQj8I/Orxu4i1lY9woJWcXanz8dPqxePolvCXUMZkCbsDcWcp9L3DJgit+5
 93vjmQNwJVecivwCFNwM6enoRBDhzdODwkKoeA4U3kdk8U+pyvIEtHJvCD+nSnFk3T2bEJt
 d3Klt0KB3WE7ZDRHxa
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
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

On Thu, Nov 20, 2025 2:25 PM, Jiawen Wu wrote:
> On Thu, Nov 20, 2025 1:48 PM, Stephen Hemminger wrote:
> > On Wed, 19 Nov 2025 16:56:24 +0800
> > Jiawen Wu <jiawenwu@trustnetic.com> wrote:
> >
> > > @@ -28,6 +29,9 @@ void txgbe_init_ops_aml40(struct txgbe_hw *hw)
> > >  	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml40;
> > >  	mac->get_link_capabilities = txgbe_get_link_capabilities_aml40;
> > >  	mac->check_link = txgbe_check_mac_link_aml40;
> > > +
> > > +	/* MAILBOX */
> > > +	mbx->host_interface_command = txgbe_host_interface_command_aml;
> > >  }
> >
> > Maybe that comment means something to you, but it seems like something
> > the next maintainer would not know what it means. Could you explain it more?
> 
> For different devices, the mailbox flow between software and firmware is
> different. There are several mailbox command in the txgbe driver, but only
> txgbe_hic_sr_read() was changed to use the new flow in commit
> 6a139ade82e7 ("net/txgbe: add new SW-FW mailbox interface"). Because
> this function invoke the txgbe_hic_unlocked() directly without SW-FW
> semaphore, I guess.
> 
> It lead to other mailbox commands timeout for Amber-Lite devices, which
> is required to use the new flow. So this patch fills in the missing part.
> 
> For the sake of code tidy, txgbe_hic_sr_read() should change to use the
> locked function txgbe_host_interface_command(), and this function could
> be change to pointer in struct txgbe_mbx_info for different devices.

Hi Stephen Hemminger,

Does this explanation is sufficient? Should I send v2 patch with these logs?
 

