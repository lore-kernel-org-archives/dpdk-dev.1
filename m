Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4254BC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 15:01:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36DB64027F;
	Tue, 11 Mar 2025 16:01:07 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7B61640263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:01:05 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2B14622065;
 Tue, 11 Mar 2025 16:01:05 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] hash_readwrite_autotest: fix printf parameters
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 11 Mar 2025 16:01:04 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FAEC@smartserver.smartshare.dk>
In-Reply-To: <20250311143948.GA16011@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] hash_readwrite_autotest: fix printf parameters
Thread-Index: AduSk3Njo5YuHf6ITK6GunrnhXU5HwAAmPGQ
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <Z8q16Ikzl4_flbpK@bricha3-mobl1.ger.corp.intel.com>
 <20250307223401.GA27687@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Z87ER_iHAgTw1wuO@bricha3-mobl1.ger.corp.intel.com>
 <20250310083640.46df23bb@hermes.local>
 <20250311143948.GA16011@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Andre Muezerie" <andremue@linux.microsoft.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
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

> From: Andre Muezerie [mailto:andremue@linux.microsoft.com]
> Sent: Tuesday, 11 March 2025 15.40
>=20
> On Mon, Mar 10, 2025 at 08:36:40AM -0700, Stephen Hemminger wrote:
> > On Mon, 10 Mar 2025 10:51:51 +0000
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> >
> > > On Fri, Mar 07, 2025 at 02:34:01PM -0800, Andre Muezerie wrote:
> > > > On Fri, Mar 07, 2025 at 09:01:28AM +0000, Bruce Richardson =
wrote:
> > > > > On Thu, Mar 06, 2025 at 12:03:28PM -0800, Andre Muezerie =
wrote:
> > > > > > Compiling with MSVC logs the warnings below, which result in
> > > > > > build error:
> > > > > >
> > > > > > ../app/test/test_hash_readwrite.c(73): warning C4476:
> 'printf' :
> > > > > >     unknown type field character ''' in format specifier
> > > > > > ../app/test/test_hash_readwrite.c(75): warning C4474:
> 'printf' :
> > > > > >     too many arguments passed for format string
> > > > > > ../app/test/test_hash_readwrite.c(75): note: placeholders =
and
> > > > > >     their parameters expect 2 variadic arguments, but 4 were
> provided
> > > > > >
> > > > > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > > > > ---
> > > > > >  app/test/test_hash_readwrite.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > IF the "'" character is not supported, is there some other
> method to do
> > > > > thousands grouping in MSVC?
> > > > >
> > > > > /Bruce
> > > >
> > > > The problem exists with all compilers I tried on Windows:
> > > >
> > > > 1) MSVC logs the error I mentioned above
> > > >
> > > > 2) GCC and Clang don't complain at compile time, but don't honor
> the "'" as a special
> > > > character. As an example,
> > > > printf("%'d\n", 1024);
> > > > results in
> > > > 'd
> > > >
> > > > It seems that for this syntax to work as you would expect,
> support needs to exist in both the
> > > > compiler and the libraries used.
> > > >
> > > > Back to your question: there's no equivalent syntax on Windows
> that provides the thousands grouping.
> > > > If really needed (and I understand it is useful for large
> numbers), we could get the same result
> > > > by calling a helper function that would convert the number in =
the
> formatted string and use that
> > > > in the printf statement.
> > > >
> > > > There is a Win32 API that does that. It takes a string as input
> though: GetNumberFormatA.
> > > > (https://learn.microsoft.com/en-us/windows/win32/api/winnls/nf-
> winnls-getnumberformata)
> > > >
> > > > We could use ifdefs to keep the old logic on Linux and use new
> logic on Windows (for all compilers).
> > > >
> > > > Let me know if this is something that would need to be done, or
> if the current output
> > > > without thousands grouping is good enough.
> > > > --
> > > The thousands grouping is incredibly helpful when working with
> large
> > > numbers, but given the lack of support for this on Windows, we'll
> just have
> > > to go without, I think.
> > >
> > > /Bruce
> >
> > Maybe some variation of the pretty printing code that iproute2 has
> > (see print_num) would be useful. Feel free to reuse it.
> > I wrote the initial version.
>=20
> That's an interesting suggestion. I'll use that.

Often "123 M" is better than "123123123", but sometimes seeing the last =
digit move is important, e.g. when looking at packet counters.

Just mentioning, so you consider which format is better every time you =
use it.

