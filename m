Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444F6C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 18:07:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F0C04064A;
	Wed, 26 Mar 2025 19:07:02 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 109DE402E3;
 Wed, 26 Mar 2025 19:07:01 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D58D02064E;
 Wed, 26 Mar 2025 19:07:00 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH] build: reduce use of AVX compiler flags
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 26 Mar 2025 19:06:58 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB76@smartserver.smartshare.dk>
In-Reply-To: <Z-QposchDMAmn83I@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] build: reduce use of AVX compiler flags
Thread-Index: Adueaz5wiwZQ0oo3S7KJT1pyloUmBwACwotA
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <Z-QposchDMAmn83I@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: <techboard@dpdk.org>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Wednesday, 26 March 2025 17.22
>=20
> On Tue, Mar 25, 2025 at 05:22:15PM +0000, Bruce Richardson wrote:
> > When doing a build for a target that already has the instruction =
sets
> > for AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or =
the
> > skylake-avx512 '-march' flags, as they are unnecessary. Instead, =
when
> > the default flags produce the desired output, just use them
> unmodified.
> >
> > Depends-on: series-34915 ("remove component-specific logic for AVX
> builds")
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >
> > This patchset depends on the previous AVX rework. However, sending =
it
> > separately as a new RFC because it effectively increases the minimum
> > compiler versions needed for x86 builds - from GCC 5 to 6, and
> > Clang 3.6 to 3.9.
> >
> > For now, I've just documented that as an additional note in the GSG
> that
> > these versions are recommended, but it would be simpler if we could
> just
> > set them as the required minimum baseline (at least in the docs).
> >
> > Feedback on these compiler version requirements welcome.
> >
>=20
> +techboard
>=20
> Ping for a little bit of feedback for this. Are we ok to bump the
> minimum
> compiler versions as described above, or will I continue with the
> approach
> in this RFC of keeping the minimum and just recommending the higher
> versions for x86 platforms?
>=20
> For reference GCC 6.1 was released April 2016[1], and, Clang 3.9 was
> released Sept 2016[2]
>=20
> /Bruce
>=20
> [1] https://gcc.gnu.org/gcc-6/
> [2] https://releases.llvm.org/

Considering GCC versions shipped with RHEL [3]...
We kind of support RHEL 7, but we already require a newer compiler (GCC =
5) than shipped with RHEL 7 (GCC 4.8).
RHEL 8 ships with GCC 8, which was released in May 2018 [4]. Maybe we =
can jump to GCC 8?

BTW, we should also apply the same principle I argued [5] should apply =
for upgrading the Kernel requirements: There should be a need for =
specific feature or similar - which there is with your patch - and the =
details should be mentioned in the release notes.

[3]: https://access.redhat.com/solutions/19458
[4]: https://gcc.gnu.org/gcc-8/
[5]: =
https://inbox.dpdk.org/dev/CAMEVEZutf4sJ=3DEQFONw_bJW0tGTWqTbF_Tk_y38qzBL=
ccco46Q@mail.gmail.com/T/#me7c8f1dbe4331ccf232d43512d6ddb51458c568a

