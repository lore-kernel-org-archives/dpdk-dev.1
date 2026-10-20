Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A57606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ce9BdiJ5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B260040663;
	Tue, 20 Oct 2026 09:40:24 +0200 (CEST)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53]) by mails.dpdk.org (Postfix) with ESMTP id B7C8C40144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 08:13:55 +0200 (CEST)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-675617e81f9so2463012d50.3
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792476835; cv=none;
 d=google.com; s=arc-20260327;
 b=MJubF47O4s1PLYDzlyuWhpgVVV5QKMilxR95k+vm24+i52OICpoR/UHpYuGb19cU65
 oFLwA1SMdsX9h5IgG/LxLzV1hOFnVZfN28mF0ZbfBI6G3NLPzhhu2sI6OxpXEte85Uoo
 zpEfhZP00y810eyxseH5nFTlJ28V62HD6zDAy8GxeMRzu38Zj1tyoG00WfpMtHwJJN1/
 gm9Egm5FUkA8FUE3QwWYqxvVsnv3EI76I7teXWpJ81eIIsSNoxy4BJD1Go8qrOOCF27k
 j0AteIOgYWCwf2nrlivsDCo6jBgsvkGI2UNbYOx+tPyBkUciuYoY2Ls/ufLzfw5XQIqh
 uALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FnwM2BRPyOUplW/g0fKmJp2FaOrs90g6lSnJRe2n8k0=;
 fh=zMJXq2AVYepUpuIAojy13HHEsWniU8QcPKbRb8cFLw0=;
 b=qqPtVgh2lqOPbFQ06DakUeNoVMj+aPQIGI7/+5XdQ94/ImzJJRDAFuJEzbvb+8hkZz
 a8decXuEpw0uaHmNY698wRdLZKZE3zE/CPKilR/rpq9iN8SuQvoQ7tr+6p1HIpyE5fbo
 ULw4DMDbMNUmrxHGpFOsbSYIEG8Czg2lJnWXFs24MRJcIeKzSO1kL7+FvrSIlSmXkbKg
 tlez0St6AMA4oGmRqwQ313XYf0SlUnlCE00PZ2Lahs/Ntycmx03fFpfgw8ziiZ9m6YVr
 L+qybH/ARJ9FkFANZOfHm5A5N/nXinnX4e7QhlW0NZFGkjeXckww9BtL+BWMYb/iOlt+
 MnhQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792476835; x=1793081635; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FnwM2BRPyOUplW/g0fKmJp2FaOrs90g6lSnJRe2n8k0=;
 b=ce9BdiJ5sjFJVm0J80buZ2DvNCQxMi1ojGePE3qAMocfaffEj4c9Cur1961G2FvpLk
 1+HEInNCjIkHWvtuJsOA21w9ym3V1G/2wXp70cV9X/7oyNz3XGbHjlqOanLB6BQCiOqb
 hgfMB+OpOSrt/VXguEfHWwKcBM0x199VENb33LQiV3aePSwpFqNhoPCwZ7KtFWvgGsC6
 VfpCHl45g4rJcTBrhxMImeYUjoseoa11ohIIUReD3yWyzlsQksBcPUom7zZQ9+n9pUv/
 bFSaLkwCEej1biyDSI1a4Bpe/f14jyOaZLr0x9V8pjSYsiAOPLRlsCLovMNU41/7PyjN
 BduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792476835; x=1793081635;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FnwM2BRPyOUplW/g0fKmJp2FaOrs90g6lSnJRe2n8k0=;
 b=RcHJnXtVW3uH+wwm1n6f9puOQBdoRTsUIXZ4t9zojCOku30IgqTYnsmLQ0RZSKhY1A
 LDhQPPH6UMIhWY8z5ZZU8ypGUhA2psfDgCpydO2wG94DN3FP3TVL8My2u66UNt6djb+d
 uenCtBZrJyvS9q02WQe53+9IeR7krrl04dIF41SVkhTe0MUVBFo6WysS905i8GUezprp
 IwYMdTqWo4Anq3VxWaq9wv2c2/05xtqgBBdhesYdxG+wuslPvHJLWfUaxOn5vflHXtQq
 E8zCmyyjFOXUQUMDtaHzfCdECwn2I6FO4SoZZ14W4Fsx7tLysJoG2U53nkIoPJFN+ALi
 RECg==
X-Forwarded-Encrypted: i=1;
 AKwUvByBukVeKrALydmpGQ+YYoOigfaqJBCaLVEZJRQLjsHfAfINHI4SQO/W0cBlAqaGU06BZGY=@dpdk.org
X-Gm-Message-State: AFq9FYLfbrNQGvDpZfaEu0i3dA+w6MHiL+H3JMdBjZuTWDJBAe9OpDMY
 dMFiHQyKAg6vcx8A9BKPeHkLRUbPpfDK8+Qt1xjZCbdCvXijYNZI8WtDGplzZHRTvdnktYag5fK
 lnusR/qFIsbqy4EkusGjylkOwBGNU10s=
X-Gm-Gg: AYBFou35pUhivaBSXeNTp02zt7BuccU9keSDlbaz2lV3UtLzOG5j6rs3l4alw3RuEUO
 4h1kvBvUgAUVqQ7hneW7QyoJ5Kh0BE2K4pmiPnHIZOdFa86f5MOAphBrmcjO631hxlbsLqhfF0f
 Hruf0R/YM16lTHbmdNpGRdAqR7Ii963QE3y4iu61ljpTDjKi4ALw7h3p+eMrRRXT7EetaIrCRD6
 o2CIlGQJ50QkQeSZyns9yffAwKO3Xo666+nuSshX/1XEl8OqAEStbCZc/MzGYtsICHu10Chji6M
 S53Ve0ZtIjgG8jJKyakkCE3XN9BMz8oepfdfu2egRVeP6GO7zvr/BHg=
X-Received: by 2002:a05:690e:12ce:b0:679:a3bc:c242 with SMTP id
 956f58d0204a3-679ca701a4fmr3229822d50.32.1792476834735; Mon, 19 Oct 2026
 23:13:54 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
 <af059fd5b4297695fc4f2fc84236f7d71a71a630.1792170902.git.tathagat.dpdk@gmail.com>
 <CALuQH+WpkTCK6jSgYc0RrdSmV_3MUJ0W8=mrn9wpgQGJRRongw@mail.gmail.com>
 <CA++LmPX3NA0=qOs=p7m8=4Zxq-=gLdgMJA=EKJy=SxNKysqfwQ@mail.gmail.com>
 <20261019095500.5b577674@phoenix.local>
 <CALuQH+UTdRV=PvGaDBC+VxfQ2Qx3O7LNWeOYuP52FFmqGm0NMQ@mail.gmail.com>
In-Reply-To: <CALuQH+UTdRV=PvGaDBC+VxfQ2Qx3O7LNWeOYuP52FFmqGm0NMQ@mail.gmail.com>
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Date: Tue, 20 Oct 2026 11:43:43 +0530
X-Gm-Features: AclHuK-G2leZ7K5ceaxQIG4GE7gJ_U2WbW1KgyUOoIbbXA058lxDiF5BH3nnZWM
Message-ID: <CA++LmPXXcV=UYQJSRLnedPnW0wvXxanHcoOMnMjtdoBJQO1f_Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] net/gve: enforce DQO Tx packet length limits
To: Joshua Washington <joshwash@google.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev <dev@dpdk.org>, 
 dpdk stable <stable@dpdk.org>, Jeroen de Borst <jeroendb@google.com>,
 Rushil Gupta <rushilg@google.com>, Junfeng Guo <junfengg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 20 Oct 2026 09:40:21 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks, Joshua.

Stephen, could you please merge these, or let me know if we still need a v5=
?

On Mon, Oct 19, 2026 at 11:06=E2=80=AFPM Joshua Washington <joshwash@google=
.com> wrote:
>
> On Mon, Oct 19, 2026 at 9:55=E2=80=AFAM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Sun, 18 Oct 2026 13:24:03 +0530
> > Tathagat Priyadarshi <tathagat.dpdk@gmail.com> wrote:
> >
> > > > > +static inline bool
> > > > > +gve_tx_validate_pkt(const struct rte_mbuf *tx_pkt, bool is_tso)
> > > >
> > > > Minor nit (not worth blocking over, but maybe can be done as the
> > > > patches are being merged): can this be renamed to
> > > > gve_tx_validate_pkt_len? This is one step of many in the packet
> > > > validation pipeline.
> > >
> > > Thanks for the review, Joshua. Agreed on renaming to gve_tx_validate_=
pkt_len.
> > > This change impacts patches 9/10 and 10/10. I am happy to submit a v5
> > > series if preferred,
> > > or the maintainer can rename it upon applying.
> >
> > Renames should go through patchwork. I can cleanup commit messages and
> > release notes, that is where I stop.
>
> In that case, would it be okay to merge as-is? I will be following up
> this series directly with some TX datapath fixes of my own which are
> kind of related to Tathagat's fixes, so I can probably update the
> function name in my patch series, rather than going to v5.
