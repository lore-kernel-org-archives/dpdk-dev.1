Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E88C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 08:01:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 424D6402E1;
	Fri, 27 Jun 2025 10:01:32 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id D9B4A4025D;
 Fri, 27 Jun 2025 10:01:30 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7d20f799fe9so204181185a.2; 
 Fri, 27 Jun 2025 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751011290; x=1751616090; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5gwtROjUIMK5Zj+V7mcClH4pDu9hP9Sd1MEYx9qvzM=;
 b=XV5qB8oLq5wT6cR/hnBHsscfoa8nkDrkPwa2Wh3ID8ChHcgtTF5+pQQw1Ca6uXTRuj
 39yEKXd1TG0pu8ljFDjueLAHp1uYVVSX16wH/HgwL4Q45gMONhi6fu0/YS6JhEZPBoei
 Tc4QDPKmhhItmBxv3CpGWf1ikJKSuD5EZ3ATs7Dxdk16ZAzz5qm1Ey1sgSk86At2e9Fb
 5hKbNloAa7+ADxIe7VazpkwYS5IAZrRqSPmMMXyLOI+w8oHAdNGnSYhvj77FrYAlaQJp
 6GP1PCXPatrjMrxsISzBECSfPxtphmelBJF8pIfKFYnUhNttjehH24TJFQS9oovIeuqY
 JVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751011290; x=1751616090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d5gwtROjUIMK5Zj+V7mcClH4pDu9hP9Sd1MEYx9qvzM=;
 b=rXz5NHb8YLowzjlPSCBJRTrKgnf2x7gByKiUaYLjj4PPjJdv4pzPdleFnKQAaO6R88
 73bKrtc32rq2EsENp0BZHAncJLTr6y+GhKZE8uEEpCi5+HaUPa2S3cQQI6Zr44cRSq1L
 mRGh2TrPcvPSBxQKyOHHw8mQaZoNpdnIfh45Hqh8DAnRXhnAR/SP3Pghn9RWYj82Ncc5
 vvskTDhzy+VsB3A9Ca9cNlG7BCsQie1dHhtlqYC2+aX+iLTLfS+aEqxW5yLqbkcZ/KA2
 GEQChDYXsS5F4GxL6zOeFahb775G7miGB/JIDk6RFsFW5rq117DFvy+2wRmkcxKIte3l
 NRRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCQD3MNfyd9Q13qdELzDEO7P/RjKHmGIQA1WY1k5yNEPkHp6by5cUF++/+ZDpZ5IerXSqTrOVEMpph@dpdk.org,
 AJvYcCUkQqg5AadvHHWoeda7eP5zHxMQ8UIJ6kFjtwHd4dsLABPszxjUE6fKAGanvKwHA/Zv8R8=@dpdk.org
X-Gm-Message-State: AOJu0Yz3x17yY9Pr/k+1ZizyJzqfDx121h59hA0VI02fC0jxO+81nWXM
 bnFRaQIfJUiaORmv3ZyUlaMtsiuRc/KZ/9wSYNeB7J5sYY5FfO1WlPpQjkW+Fn/YYQ67O1v4U0M
 Jvxh+6Uq1LFaBd88hiKm752AutpNjxXc=
X-Gm-Gg: ASbGnctUUAIw6VIb3CZFhkb14d/00mwy36dPsrW3kg1vPSDZx4mIlNRn/nyf+BXVEON
 5Cn7IGzB9M16dc+YFjLuBT2JJy+jfA/DGxAlrElVM52/20Dxyp3o0gAofaZ8lxbXMul4nQu9iOH
 rvqzl0R+VFeBIDTSQfdzou5TTdNQg3/fQb6HRzTW9Lsg==
X-Google-Smtp-Source: AGHT+IE6jniZTg+x8Wg8Px9x4VWi/cqbgsaqepb0Gy5ZjqOUgO3FsUlI6g3HFMAJrWZs4/i+l0EnpRyM+1uPMMO5j4o=
X-Received: by 2002:a05:620a:2993:b0:7d4:292d:8f09 with SMTP id
 af79cd13be357-7d44398937dmr335839085a.44.1751011290030; Fri, 27 Jun 2025
 01:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <BY3PR18MB478574FF76D2777FFACB1B00C877A@BY3PR18MB4785.namprd18.prod.outlook.com>
 <ccab20d4-8620-407c-b7a9-de5b81c4d6e8@nvidia.com>
In-Reply-To: <ccab20d4-8620-407c-b7a9-de5b81c4d6e8@nvidia.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 27 Jun 2025 13:31:03 +0530
X-Gm-Features: Ac12FXxagi5Cbnicb1NuJGIC7q9OK8t0Oar_1DxCp2VbtfK3eWC83sIT0Uot44M
Message-ID: <CALBAE1MTeqJKGy1EzXV1oCq2SxmN-Y4fm4LwwkAwcHbDy_2w3Q@mail.gmail.com>
Subject: Re: Proposal: AI-Based Code Review for DPDK
To: Ori Kam <orika@nvidia.com>, Aaron Conole <aconole@redhat.com>
Cc: Jerin Jacob <jerinj@marvell.com>, dev <dev@dpdk.org>, 
 "techboard@dpdk.org" <techboard@dpdk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 19, 2025 at 7:42=E2=80=AFPM Ori Kam <orika@nvidia.com> wrote:
>
>
> Nice idea,
> Some comments:
>
>
> 1. The first link is broken for me.

Yes.  https://github.com/DPDK/dpdk-ai-code-review is the proposed name
of the repository. It is not created yet.

>
> 2. I like the idea that there is a separate GitHub repository. If I
>     understand correctly the new repository is a clone of the main one,
>     and only used by the bot is that correct?

Yes.

>
> 3. I think main usage is also for the reviewer, just like in your example=
.

Yes

>
> 4. The only thing I=E2=80=99m missing is that there is no =E2=80=9Cperson=
al touch=E2=80=9D
>     meaning that each reviewer puts emphasis on different things. It will
>     be great if the AI can learn from previous reviews of the reviewer
>     and add review accordingly.

Yes. However, It looks like https://docs.sourcery.ai/Code-Review/ dont
have that feature.

>
> 5. It will also be great if the AI could target people who may be
>     interested in this patch.  And send them some notification or tell
>     the developer to add them in the to

Good input.


Adding @Aaron Conole . He has some plans to implement this workflow.


>
> Best,
> Ori
>
> On 13/06/2025 13:03, Jerin Jacob wrote:
> >
> > Goals
> > -------
> >
> > # Leverage modern AI-powered code review tools to accelerate and supple=
ment human review efforts.
> > # Prevent AI-generated comments from cluttering the mailing list or pol=
luting the main DPDK GitHub repository.
> >
> > Setup
> > -------
> >
> > # Create a dedicated repository:
> > Set up a new repository, for example: https://github.com/DPDK/dpdk-ai-c=
ode-review, under the official DPDK GitHub organization.
> > This ensures that AI-generated pull requests do not interfere with the =
main repository (https://github.com/DPDK/dpdk).
> >
> > # Select an AI review tool:
> > Use a free, open-source-friendly AI code review service.
> > One potential candidate is Sourcery: https://sourcery.ai/pricing
> >
> > # Connect the tool:
> > Integrate Sourcery with the new repository via: https://app.sourcery.ai=
/?product=3Dprod_opensource
> >
> > # Trigger AI reviews:
> > Once integrated, any pull request to this repository will automatically=
 trigger a code review by the AI tool.
> > Example of a test PR reviewed by the AI bot:
> > https://github.com/MarvellEmbeddedProcessors/dao/pull/2
> >
> > Workflow
> > -------------
> >
> > # When a patch is sent to the DPDK mailing list, a bot will convert it =
into a GitHub pull request on the dpdk-ai-code-review repository.
> > # The AI tool will review the pull request and leave comments directly =
on the PR.
> > # Once the AI review is complete, the bot will close the PR and share t=
he PR URL:
> > - As a comment in Patchwork URL for the given patch
> > - With the patch author directly.
> > # The author can review the AI-generated comments by visiting the PR UR=
L, if they choose to do so.
> >
> >
>
