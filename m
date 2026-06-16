Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0A0CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 22:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F6ED4027A;
	Wed, 17 Jun 2026 00:46:11 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id BE3984026F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 00:46:10 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30bb7d20ad9so1650904eec.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781649970;
 x=1782254770; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vicdHRX5ibN+/NjW2GU+zrcbWhwU4BZxECUFGi+4VuQ=;
 b=zdaDTAOlNkm8+sn0vE6pL165UtvfV7Ckxz7/xQzObFIQxBnvHHOKDbT1wVLMPkh3cx
 0vcchAb8ws3jQ2mzKviBTwZb/zPv8+c3a1+eFJRVfXyyca/3nSjeLPkCW2x0PnWjbw36
 XTSuM2q15BuLBTgrUN0OTO26vxwA/hurqnq5xMOuIouUKlgtDEv/1/7aUi4A3jVaoDc+
 PuJ7QJ1ei/1JUHiZV2s8s45HxJ3UOhp7/cG39ka1SH2yTJwMq5Kwv7cXqpenXh4jdG/j
 4hnWZX2R9zxjWEsyvw1eZtug82TIkbtWfYMip40Etj3KjFiNM7NzY/fLcEAOyRMIBUf0
 TDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781649970; x=1782254770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vicdHRX5ibN+/NjW2GU+zrcbWhwU4BZxECUFGi+4VuQ=;
 b=U9PGKDN4qqLK0vRoYoLOddtefanjkGLTWy3eDptwEggXC4Sh9av+7Ol/IrCII5dhsz
 Fu0E0LcxkVA5sU2BoNjYwtoETia45rb8rRDA0zldmwOTABqnL5PgnafCPKRAnww/ChHz
 bSFUusXK7jPHQONj/PJtI6LDno3CUrBEmwiIGMq5BThahqpLi4Y5AB6/m3hyz1Nxg9Qe
 np8ixUepejoivqCamANiJqsxgnsyBT0CglWIg7TbzAeoaGac4wXWfOzXBL6GpvEFR/mO
 KzLGbIhNYCILFkDZ7q4sVHEpTEe9kxQFRM8k4djLRPM8bbCXlf8yBspAuGY0LPyn2Tmz
 ckxg==
X-Gm-Message-State: AOJu0YycsKdVb9aJTZt8B0Y6vk4I1/5YIWLdctbyI9m6Fvca0Ukpi1bB
 aU6rvY6OhCViJlysZp+yWGeVqbJQuZp7nduff5zOusozjjFx1PHZOnInqzI/7LgK3L8=
X-Gm-Gg: AfdE7cmK14HKvgTQOuL9k+LANDw9IQgUoVvphsve1dcuTWjrxe8/Q63kB10r6WDI5Hl
 VvhCBGaMSWQ6w5CP5BSDOZ3MNg0su373ETzHFqlXoH92PYPW0FXaWEzvVNc7X4ZHmJMbSNTGUXh
 ax2oacYS1djNZ0v3olnWUgf2DpRKnxFnmFWuydWQcj+4lQhU6dq37VvX7+X1HCHqyNa4kqL4MPb
 mfZIngHOFiA9UV6gOfqCLJdWaQulzr3p19PgF1AGGGeeccJdod3hO72og1+jdcJ0p0lIqR04TkU
 Bb0KgQMV/QxQKWBRh3JX2WPOEFKAjcI95Pe+iTGt6PldCKIDkiqutNzTt/sI926BD7oV416sPN7
 WD9iE+SHwlw6UFy6Cy4B8RKjH78IbXnzyAtfhWHeTSfj6Lr6CH6ziHRbqi3HNxpTjsXRHbhN2JD
 eddh4VuB4jaAVVTpo5UYFc4nMecpPGOJ2Clj+QPzeTz3px8QWLazA9Au4qBs4gAHqq
X-Received: by 2002:a05:7301:1e8a:b0:304:630d:e4ec with SMTP id
 5a478bee46e88-30bca072248mr704692eec.28.1781649969558; 
 Tue, 16 Jun 2026 15:46:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bd01b768bsm347693eec.13.2026.06.16.15.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 15:46:08 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:46:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matthew Gee <mgee@iol.unh.edu>
Cc: dev@dpdk.org, aconole@redhat.com, lylavoie@iol.unh.edu
Subject: Re: [PATCH v2] tools: AI review handle empty Error sections
Message-ID: <20260616154606.5e8a844d@phoenix.local>
In-Reply-To: <20260612190807.1020863-1-mgee@iol.unh.edu>
References: <20260612190225.1016275-1-mgee@iol.unh.edu>
 <20260612190807.1020863-1-mgee@iol.unh.edu>
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

On Fri, 12 Jun 2026 15:08:07 -0400
Matthew Gee <mgee@iol.unh.edu> wrote:

> Previous review-patch.py would detect and report and error or warning
> based off of the occurrence of the headers of the error and warning
> sections. This led to consistent false positives as often AI reviewers
> will create the header but put "none" or similar filler text within
> the following body.
> 
> This patch updates the code in order to check if the AI review has a
> body with error or warnings to fix and not just filler text. This is
> done by querying multiple lines at once and adjusting the regex to
> filter out headers followed only by filler text or formatting in the
> review.
> 
> These changes were tested against 10+ AI review outputs with several
> variations in formatting and filler text in order to catch a good
> variety of cases to make sure code reviews with actual errors or
> warnings are caught and not missed.
> 
> Signed-off-by: Matthew Gee <mgee@iol.unh.edu>
> ---

AI saw some stuff which I missed.

Matthew,

The windowing (tee/islice/chain) is aligned correctly, but the new
matching has a few problems.

The bigger issue is that this only recognizes markdown '#' headers now.
The old scan matched an optional '#' prefix, '**' bold, and '<h1-3>' too.
rgx_should_match requires "#+\s", so plain-text "Errors:" / "**Errors**"
and HTML "<h2>Errors</h2>" no longer match. Default --format is text and
html is supported, so reviews in those formats classify clean (exit 0)
even when they report errors, which silently breaks the 2/3 exit codes
compare-patch-reviews.sh relies on. The '#'/'**'/'<h>' alternatives need
to stay.

The 3-line concatenation also reintroduces the false positive you're
trying to kill. curr+next+next_next are joined with no separator, so

	## Errors
	None
	## Warnings

collapses to "## errorsnone## warnings"; the 'none...$' filler anchor
fails because the next header follows, and has_errors gets set. Any
output that doesn't blank-line-separate sections hits this.

And in the other direction, content more than two lines below a header
is missed: two blank lines between "## Errors" and the body leave
stripped == "## errors", the '$' branch matches, and a real finding is
suppressed. The heuristic ends up sensitive to exact line spacing both
ways.

Minor: iter[str] / iter[str | None] aren't valid generics (use the
already-imported Iterator); the vars are also re-annotated with
conflicting types and annotate the iterators rather than the loop
targets. mypy will reject these. Run black too - the new for/zip line
and the stripped assignment are over width.

Suggest keeping header matching in all three formats, then scanning past
blank lines to the first non-empty body line and suppressing only if
it's filler (none/n/a/empty). That decouples detection from spacing
instead of fixing it to a 3-line shape.
